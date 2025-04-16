import 'package:chat/constants.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({super.key, this.icon, required this.text});
  final IconData? icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Text(
            text,
            style: Styles.textStyle16,
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded),
          const SizedBox(width: 30),
        ],
      ),
    );
  }
}
