import 'package:chat/core/utils/styles.dart';
import 'package:flutter/material.dart';

class OnBoardingText extends StatelessWidget {
  const OnBoardingText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Styles.textStyle24,
      textAlign: TextAlign.center,
    );
  }
}
