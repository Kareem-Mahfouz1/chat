import 'package:chat/constants.dart';
import 'package:chat/core/utils/assets.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      leading: const CircleAvatar(
        radius: 22,
        backgroundImage: AssetImage(Assets.stockAvatar),
      ),
      title: Text(
        'contact',
        style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
