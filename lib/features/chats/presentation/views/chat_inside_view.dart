import 'package:chat/constants.dart';
import 'package:chat/core/errors/failures.dart';
import 'package:chat/core/utils/assets.dart';
import 'package:chat/core/widgets/custom_loading_indicator.dart';
import 'package:chat/core/widgets/empty_list.dart';
import 'package:chat/features/chats/data/models/chat_model.dart';
import 'package:chat/features/chats/data/models/message_model.dart';
import 'package:chat/features/chats/data/repos/messages_repo_impl.dart';
import 'package:chat/features/chats/presentation/cubits/chats_cubit/chats_cubit.dart';
import 'package:chat/features/chats/presentation/cubits/messages_cubit/messages_cubit.dart';
import 'package:chat/features/chats/presentation/views/widgets/chat_inside_appbar.dart';
import 'package:chat/features/chats/presentation/views/widgets/chat_text_field.dart';
import 'package:chat/features/chats/presentation/views/widgets/message_item_wrapper.dart';
import 'package:dartz/dartz.dart' show Either;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatInsideView extends StatefulWidget {
  const ChatInsideView({super.key, required this.chatModel});
  final ChatModel chatModel;

  @override
  State<ChatInsideView> createState() => _ChatInsideViewState();
}

class _ChatInsideViewState extends State<ChatInsideView>
    with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Message> _messages = [];
  late ChatsCubit _chatsCubit;

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    if (bottomInset > 0.0) {
      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _chatsCubit = context.read<ChatsCubit>();
    Future.microtask(() {
      if (mounted) {
        context
            .read<ChatsCubit>()
            .setUserInChatStatus(widget.chatModel.chatId, true);
      }
    });
    Future.microtask(() {
      if (mounted) {
        context.read<ChatsCubit>().markAsRead(widget.chatModel.chatId);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _chatsCubit.setUserInChatStatus(widget.chatModel.chatId, false);
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

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
            child: StreamBuilder<Either<Failure, List<Message>>>(
              stream: MessageRepoImpl().streamMessages(widget.chatModel.chatId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    !snapshot.hasData) {
                  return const CustomLoadingIndicator();
                }
                final result = snapshot.data!;
                return result.fold(
                  (failure) => Center(child: Text(failure.errMessage)),
                  (messages) {
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      if (_messages.length < messages.length) {
                        final newItems = messages.sublist(_messages.length);
                        for (int i = 0; i < newItems.length; i++) {
                          _messages.add(newItems[i]);
                          _listKey.currentState
                              ?.insertItem(_messages.length - 1);
                        }
                        await context
                            .read<ChatsCubit>()
                            .markAsRead(widget.chatModel.chatId);
                      }
                      _scrollToBottom();
                    });

                    return messages.isEmpty
                        ? const EmptyListIndicator(text: 'No messages yet')
                        : AnimatedList(
                            key: _listKey,
                            controller: _scrollController,
                            initialItemCount: _messages.length,
                            itemBuilder: (context, index, animation) {
                              final msg = _messages[index];
                              return MessageItemWrapper(
                                  message: msg, animation: animation);
                            },
                          );
                  },
                );
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
