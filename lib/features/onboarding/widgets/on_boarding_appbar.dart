import 'package:chat/constants.dart';
import 'package:chat/features/onboarding/widgets/skip_button.dart';
import 'package:flutter/material.dart';

class OnBoardingAppbar extends StatelessWidget {
  const OnBoardingAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: kHorizontalPadding, top: 50),
          child: SkipButton(),
        ),
      ],
    );
  }
}
