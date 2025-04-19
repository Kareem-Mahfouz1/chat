import 'package:chat/core/utils/assets.dart';
import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator(
      {super.key, this.width = 100, this.height = 100});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.loadingSpinner,
      width: width,
      height: height,
    );
  }
}
