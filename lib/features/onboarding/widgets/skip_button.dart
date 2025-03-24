import 'package:chat/constants.dart';
import 'package:chat/core/utils/app_router.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        backgroundColor: kPrimaryColor25,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
      ),
      onPressed: () {
        GoRouter.of(context).go(AppRouter.kRegisterView);
      },
      child: const Text(
        'Skip',
        style: Styles.textStyle14Medium,
      ),
    );
  }
}
