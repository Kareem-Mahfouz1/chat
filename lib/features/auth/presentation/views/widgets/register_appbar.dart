import 'package:chat/constants.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:flutter/material.dart';

class RegisterAppbar extends StatelessWidget {
  const RegisterAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text(
              'Register',
              style: Styles.textStyle30.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              'Fill up your details to register.',
              style: Styles.textStyle20.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 35)
          ],
        ),
      ),
    );
  }
}
