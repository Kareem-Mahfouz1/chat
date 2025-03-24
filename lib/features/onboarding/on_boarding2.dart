import 'package:chat/constants.dart';
import 'package:chat/core/utils/app_router.dart';
import 'package:chat/core/utils/assets.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:chat/core/widgets/my_button.dart';
import 'package:chat/features/onboarding/widgets/on_boarding_appbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const OnBoardingAppbar(),
          const SizedBox(height: 20),
          Image.asset(
            Assets.onBoardingImage,
          ),
          const SizedBox(height: 30),
          const Text(
            'If you are confused about \nwhat to do just open \nChatboat app',
            style: Styles.textStyle24,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: SizedBox(
              width: double.infinity,
              child: MyButton(
                text: 'Next',
                onPressed: () {
                  GoRouter.of(context).go(AppRouter.kOnBoarding3);
                },
              ),
            ),
          ),
          const SizedBox(height: 70)
        ],
      ),
    );
  }
}
