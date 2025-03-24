import 'package:chat/constants.dart';
import 'package:chat/core/utils/input_border.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:chat/core/utils/validators.dart';
import 'package:chat/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:chat/features/auth/presentation/cubits/password_visibility_cubit/password_visibility_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFields extends StatelessWidget {
  const LoginFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        spacing: 36,
        children: [
          TextFormField(
            controller: context.read<LoginCubit>().emailController,
            validator: Validator.validateEmail,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Enter your email',
              floatingLabelStyle:
                  Styles.textStyle14Regular.copyWith(color: kPrimaryColor),
              label: const Text('Email'),
              focusedBorder: inputDecoration(),
              enabledBorder: inputDecoration(),
              border: inputDecoration(),
            ),
          ),
          BlocBuilder<PasswordVisibilityCubit, bool>(
            builder: (context, isObscured) {
              return TextFormField(
                controller: context.read<LoginCubit>().passwordController,
                obscureText: isObscured,
                validator: Validator.validatePassword,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  floatingLabelStyle:
                      Styles.textStyle14Regular.copyWith(color: kPrimaryColor),
                  label: const Text('Password'),
                  focusedBorder: inputDecoration(),
                  enabledBorder: inputDecoration(),
                  border: inputDecoration(),
                  suffixIcon: IconButton(
                    icon: Icon(
                        isObscured ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      context
                          .read<PasswordVisibilityCubit>()
                          .toggleVisibility();
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
