import 'package:chat/constants.dart';
import 'package:chat/core/utils/assets.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:chat/features/chats/data/models/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key, required this.chat});
  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final otherId = chat.participants.firstWhere((id) => id != currentUserId);
    final otherName = chat.participantNames[otherId] ?? "Unknown";
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      leading: const CircleAvatar(
        radius: 22,
        backgroundImage: AssetImage(Assets.stockAvatar),
      ),
      title: Text(
        otherName,
        style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(chat.lastMessage),
      trailing: Text(
        TimeOfDay.fromDateTime(chat.lastUpdated).format(context),
        style:
            Styles.textStyle14Regular.copyWith(color: const Color(0x99191919)),
      ),
    );
  }
}
