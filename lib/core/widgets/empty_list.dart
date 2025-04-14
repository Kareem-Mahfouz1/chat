import 'package:chat/core/utils/assets.dart';
import 'package:flutter/material.dart';

class EmptyListIndicator extends StatelessWidget {
  const EmptyListIndicator({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.noData,
          width: 200,
          height: 200,
        ),
        Text(text)
      ],
    );
  }
}
