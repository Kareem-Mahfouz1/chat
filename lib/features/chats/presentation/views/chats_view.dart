import 'package:chat/core/utils/app_router.dart';
import 'package:chat/features/chats/presentation/views/widgets/chat_item.dart';
import 'package:chat/features/chats/presentation/views/widgets/chats_appbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ChatsAppbar(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: 10,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kChatInsideView);
                  },
                  child: const ChatItem(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
