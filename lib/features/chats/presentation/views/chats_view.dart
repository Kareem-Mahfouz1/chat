import 'package:chat/core/utils/app_router.dart';
import 'package:chat/core/utils/assets.dart';
import 'package:chat/core/widgets/custom_loading_indicator.dart';
import 'package:chat/features/chats/presentation/cubits/chats_cubit/chats_cubit.dart';
import 'package:chat/features/chats/presentation/views/widgets/chat_item.dart';
import 'package:chat/features/chats/presentation/views/widgets/chats_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChatsView extends StatefulWidget {
  const ChatsView({super.key});

  @override
  State<ChatsView> createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  @override
  void initState() {
    context.read<ChatsCubit>().streamUserChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ChatsAppbar(),
          Expanded(child: BlocBuilder<ChatsCubit, ChatsState>(
            builder: (context, state) {
              if (state is ChatsFailure) {
                return Center(child: Text(state.errMessage));
              } else if (state is ChatsSuccess) {
                return state.chatList.isEmpty
                    ? Center(
                        child: Image.asset(
                          Assets.noData,
                          width: 200,
                          height: 200,
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: state.chatList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              GoRouter.of(context)
                                  .push(AppRouter.kChatInsideView);
                            },
                            child: ChatItem(chat: state.chatList[index]),
                          );
                        },
                      );
              } else if (state is ChatsLoading) {
                return const CustomLoadingIndicator();
              } else {
                return const Center(child: Text('initial'));
              }
            },
          )),
        ],
      ),
    );
  }
}
