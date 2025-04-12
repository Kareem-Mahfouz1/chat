import 'package:chat/constants.dart';
import 'package:chat/core/utils/app_router.dart';
import 'package:chat/core/utils/assets.dart';
import 'package:chat/core/widgets/my_button.dart';
import 'package:chat/features/onboarding/cubits/on_boarding_cubit.dart';
import 'package:chat/features/onboarding/widgets/on_boarding_appbar.dart';
import 'package:chat/features/onboarding/widgets/on_boarding_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  final List<String> texts = const [
    'Welcome to Chatboat,\na great friend to chat\nwith you.',
    'Feeling confused? Just open\nChatboat and start chatting.',
    'Chatboat is always ready\nto cheer you up!',
  ];

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
          SizedBox(
            height: 150,
            child: BlocBuilder<OnBoardingCubit, int>(
              builder: (context, state) {
                final cubit = context.read<OnBoardingCubit>();
                return PageView.builder(
                  controller: cubit.controller,
                  onPageChanged: cubit.setPage,
                  itemCount: texts.length,
                  itemBuilder: (context, index) =>
                      OnBoardingText(text: texts[index]),
                );
              },
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: SizedBox(
              width: double.infinity,
              child: BlocBuilder<OnBoardingCubit, int>(
                builder: (context, state) {
                  final cubit = context.read<OnBoardingCubit>();
                  return MyButton(
                    text: state == texts.length - 1 ? 'Get Started' : 'Next',
                    onPressed: () {
                      if (state == texts.length - 1) {
                        GoRouter.of(context).go(AppRouter.kRegisterView);
                      } else {
                        cubit.nextPage(texts.length);
                      }
                    },
                  );
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
