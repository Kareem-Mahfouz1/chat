import 'package:chat/constants.dart';
import 'package:chat/core/utils/app_router.dart';
import 'package:chat/core/utils/assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    handleNavigation();
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

  void handleNavigation() async {
    await Future.delayed(const Duration(seconds: 3));
    // //TODO
    // await FirebaseAuth.instance.signOut();

    final prefs = await SharedPreferences.getInstance();
    final onboardingComplete = prefs.getBool('onboarding_completed') ?? false;

    final user = FirebaseAuth.instance.currentUser;

    if (mounted) {
      if (!onboardingComplete) {
        GoRouter.of(context).go(AppRouter.kOnBoardingView);
      } else if (user != null) {
        GoRouter.of(context).go(AppRouter.kHomeView);
      } else {
        GoRouter.of(context).go(AppRouter.kRegisterView);
      }
    }
  }
}
