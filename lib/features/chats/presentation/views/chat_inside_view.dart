import 'package:chat/constants.dart';
import 'package:chat/core/utils/assets.dart';
import 'package:chat/features/chats/presentation/views/widgets/chat_inside_appbar.dart';
import 'package:chat/features/chats/presentation/views/widgets/chat_text_field.dart';
import 'package:chat/features/chats/presentation/views/widgets/message_item.dart';
import 'package:flutter/material.dart';

class ChatInsideView extends StatelessWidget {
  const ChatInsideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Container(
            color: kBackgroundColor,
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
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    index % 2 == 0 ? const Spacer() : const SizedBox(),
                    MessageItem(
                      text: 'abcdefghijklmnopqrsyz$index',
                      date: "8:57 AM",
                    ),
                  ],
                );
              },
            ),
          ),
          const Column(
            children: [
              ChatInsideAppbar(),
              Spacer(),
              ChatTextField(),
            ],
          ),
        ],
      ),
    );
  }
}
