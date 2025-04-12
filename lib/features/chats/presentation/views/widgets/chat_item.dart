import 'package:chat/constants.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      leading: const CircleAvatar(
        radius: 22,
        backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
      ),
      title: Text(
        'User Name',
        style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: const Text('Last message'),
      trailing: Text(
        'Time',
        style:
            Styles.textStyle14Regular.copyWith(color: const Color(0x99191919)),
      ),
    );
  }
}
