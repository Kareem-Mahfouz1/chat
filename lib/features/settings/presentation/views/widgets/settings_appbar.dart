import 'package:chat/constants.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:flutter/material.dart';

class SettingsAppbar extends StatelessWidget {
  const SettingsAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          right: kHorizontalPadding,
          left: kHorizontalPadding,
          top: 30,
          bottom: 25,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Settings',
              style: Styles.textStyle24.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
