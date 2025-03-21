import 'package:chat/constants.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:chat/core/widgets/my_button.dart';
import 'package:chat/features/auth/presentation/views/register_view.dart';
import 'package:chat/features/auth/presentation/views/widgets/login_appbar.dart';
import 'package:chat/features/auth/presentation/views/widgets/login_field.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const LoginAppbar(),
            const SizedBox(height: 100),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Column(
                  children: [
                    const LoginField(),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: MyButton(
                        text: 'Login',
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(height: 25),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RegisterView()));
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Dont have an account ',
                              style: Styles.textStyle12
                                  .copyWith(color: Colors.black87),
                            ),
                            TextSpan(
                              text: 'Register',
                              style: Styles.textStyle12.copyWith(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
