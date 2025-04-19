import 'package:chat/constants.dart';
import 'package:chat/core/utils/assets.dart';
import 'package:chat/core/widgets/custom_loading_indicator.dart';
import 'package:chat/core/widgets/empty_list.dart';
import 'package:chat/features/chats/data/models/chat_model.dart';
import 'package:chat/features/chats/presentation/cubits/messages_cubit/messages_cubit.dart';
import 'package:chat/features/chats/presentation/views/widgets/chat_inside_appbar.dart';
import 'package:chat/features/chats/presentation/views/widgets/chat_text_field.dart';
import 'package:chat/features/chats/presentation/views/widgets/message_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatInsideView extends StatefulWidget {
  const ChatInsideView({super.key, required this.chatModel});
  final ChatModel chatModel;

  @override
  State<ChatInsideView> createState() => _ChatInsideViewState();
}

class _ChatInsideViewState extends State<ChatInsideView> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final otherUserId = widget.chatModel.participants
        .firstWhere((uid) => uid != FirebaseAuth.instance.currentUser!.uid);
    final otherUserName =
        widget.chatModel.participantNames[otherUserId] ?? "Unknown";
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Container(
            color: kChatBackgroundColor,
          )),
          Positioned.fill(
            child: Image.asset(
              fit: BoxFit.cover,
              Assets.chatBackground,
            ),
          ),
          Positioned.fill(
            top: 80,
            bottom: 65,
            child: BlocBuilder<MessagesCubit, MessagesState>(
              builder: (context, state) {
                if (state is MessagesFailure) {
                  return Center(child: Text(state.errMessage));
                } else if (state is MessagesSuccess) {
                  final messages = state.messageList;
                  return messages.isEmpty
                      ? const EmptyListIndicator(text: 'No messages yet')
                      : ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final msg = messages[index];
                            final isMe = msg.senderId ==
                                FirebaseAuth.instance.currentUser?.uid;
                            return Row(
                              children: [
                                if (!isMe) const SizedBox() else const Spacer(),
                                MessageItem(
                                  text: msg.text,
                                  date: TimeOfDay.fromDateTime(msg.timestamp)
                                      .format(context),
                                ),
                              ],
                            );
                          },
                        );
                } else if (state is MessagesLoading) {
                  return const CustomLoadingIndicator();
                } else {
                  return const Center(child: Text('initial'));
                }
              },
            ),
          ),
          Column(
            children: [
              ChatInsideAppbar(name: otherUserName),
              const Spacer(),
              BlocListener<MessagesCubit, MessagesState>(
                listenWhen: (previous, current) {
                  return current is MessageSendFailure;
                },
                listener: (context, state) {
                  if (state is MessageSendFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errMessage)),
                    );
                  }
                },
                child: ChatTextField(chatId: widget.chatModel.chatId),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
