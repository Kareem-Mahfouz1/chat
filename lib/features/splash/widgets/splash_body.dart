import 'package:chat/constants.dart';
import 'package:chat/core/utils/app_router.dart';
import 'package:chat/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadingAnimation;

  @override
  void initState() {
    initAnimation();
    navigateToHome();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: fadingAnimation,
        child: Stack(
          children: [
            Positioned.fill(
                child: Container(
              color: kPrimaryColor,
            )),
            Positioned.fill(
              child: Image.asset(
                fit: BoxFit.cover,
                Assets.splashBackground,
              ),
            ),
            Center(
              child: Image.asset(
                Assets.chatIcon,
                width: MediaQuery.of(context).size.width * .4,
              ),
            ),
          ],
        ));
  }

  void initAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutCubic,
    );

    fadingAnimation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (mounted) {
          GoRouter.of(context).go(AppRouter.kOnBoardingView);
        }
      },
    );
  }
}
