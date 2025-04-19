import 'package:chat/constants.dart';
import 'package:chat/core/utils/assets.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:chat/features/chats/data/models/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key, required this.chat});
  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final otherId = chat.participants.firstWhere((id) => id != currentUserId);
    final otherName = chat.participantNames[otherId] ?? "Unknown";

    final now = DateTime.now();
    final lastUpdated = chat.lastUpdated;
    String trailingText;
    final today = DateTime(now.year, now.month, now.day);
    final lastDay =
        DateTime(lastUpdated.year, lastUpdated.month, lastUpdated.day);

    if (lastDay == today) {
      trailingText = DateFormat('h:mm a').format(lastUpdated);
    } else if (lastDay == today.subtract(const Duration(days: 1))) {
      trailingText = 'Yesterday';
    } else {
      trailingText = DateFormat('dd/MM/yy').format(lastUpdated);
    }

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
      subtitle: Text(
        chat.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        trailingText,
        style:
            Styles.textStyle14Regular.copyWith(color: const Color(0x99191919)),
      ),
    );
  }
}
