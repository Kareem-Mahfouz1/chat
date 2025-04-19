import 'package:chat/features/chats/data/models/message_model.dart';
import 'package:chat/features/chats/presentation/views/widgets/message_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageItemWrapper extends StatelessWidget {
  final Message message;
  final Animation<double> animation;

  const MessageItemWrapper({
    super.key,
    required this.message,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final isMe = message.senderId == FirebaseAuth.instance.currentUser!.uid;
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(isMe ? 1 : -1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: Row(
        children: [
          if (!isMe) const SizedBox() else const Spacer(),
          MessageItem(
            text: message.text,
            date: TimeOfDay.fromDateTime(message.timestamp).format(context),
          ),
        ],
      ),
    );
  }
}
