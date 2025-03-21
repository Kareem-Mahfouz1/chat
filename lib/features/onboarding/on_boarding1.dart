import 'package:chat/constants.dart';
import 'package:chat/core/utils/assets.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:chat/core/widgets/my_button.dart';
import 'package:chat/features/onboarding/on_boarding2.dart';
import 'package:chat/features/onboarding/widgets/on_boarding_appbar.dart';
import 'package:flutter/material.dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({super.key});

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
            'Welcome to chatboat,\na great friend to chat\n with you',
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const OnBoarding2(),
                  ));
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
