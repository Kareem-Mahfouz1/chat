import 'package:chat/constants.dart';
import 'package:chat/core/utils/assets.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({super.key, this.onTap, required this.name});
  final Function()? onTap;
  final String name;

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
        name,
        style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}
