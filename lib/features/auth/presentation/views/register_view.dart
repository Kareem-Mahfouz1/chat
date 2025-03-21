import 'package:chat/constants.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:chat/core/widgets/my_button.dart';
import 'package:chat/features/auth/presentation/views/login_view.dart';
import 'package:chat/features/auth/presentation/views/widgets/register_appbar.dart';
import 'package:chat/features/auth/presentation/views/widgets/register_fields.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const RegisterAppbar(),
            const SizedBox(height: 45),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Column(
                  children: [
                    const RegisterFields(),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: MyButton(
                        text: 'Register',
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(height: 25),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginView()));
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account ',
                              style: Styles.textStyle12
                                  .copyWith(color: Colors.black87),
                            ),
                            TextSpan(
                              text: 'Login',
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
