import 'package:chat/constants.dart';
import 'package:chat/core/utils/app_router.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:chat/core/widgets/custom_loading_indicator.dart';
import 'package:chat/core/widgets/my_button.dart';
import 'package:chat/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:chat/features/auth/presentation/cubits/password_visibility_cubit/password_visibility_cubit.dart';
import 'package:chat/features/auth/presentation/views/widgets/login_appbar.dart';
import 'package:chat/features/auth/presentation/views/widgets/login_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 50,
            ),
            child: Column(
              children: [
                const LoginAppbar(),
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kHorizontalPadding),
                  child: Column(
                    children: [
                      BlocProvider(
                        create: (context) => PasswordVisibilityCubit(),
                        child: const LoginFields(),
                      ),
                      const SizedBox(height: 80),
                      SizedBox(
                        width: double.infinity,
                        child: BlocConsumer<LoginCubit, LoginState>(
                          listener: (context, state) {
                            if (state is LoginSuccess) {
                              GoRouter.of(context).go(AppRouter.kHomeView);
                            } else if (state is LoginFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.errMessage),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return state is LoginLoading
                                ? const CustomLoadingIndicator()
                                : MyButton(
                                    text: 'Login',
                                    onPressed: () {
                                      context.read<LoginCubit>().login();
                                    },
                                  );
                          },
                        ),
                      ),
                      const SizedBox(height: 25),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).pop();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
