import 'package:chat/constants.dart';
import 'package:chat/core/utils/input_border.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:chat/core/utils/validators.dart';
import 'package:chat/features/auth/presentation/cubits/password_visibility_cubit/password_visibility_cubit.dart';
import 'package:chat/features/auth/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterFields extends StatelessWidget {
  const RegisterFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<RegisterCubit>().formKey,
      child: Column(
        spacing: 28,
        children: [
          TextFormField(
            validator: Validator.validateName,
            decoration: InputDecoration(
              hintText: 'Enter your name',
              floatingLabelStyle:
                  Styles.textStyle14Regular.copyWith(color: kPrimaryColor),
              label: const Text(
                'Name',
              ),
              focusedBorder: inputDecoration(),
              enabledBorder: inputDecoration(),
              border: inputDecoration(),
            ),
          ),
          TextFormField(
            validator: Validator.validateEmail,
            controller: context.read<RegisterCubit>().emailController,
            decoration: InputDecoration(
              hintText: 'Enter your email',
              floatingLabelStyle:
                  Styles.textStyle14Regular.copyWith(color: kPrimaryColor),
              label: const Text(
                'Email',
              ),
              focusedBorder: inputDecoration(),
              enabledBorder: inputDecoration(),
              border: inputDecoration(),
            ),
          ),
          BlocBuilder<PasswordVisibilityCubit, bool>(
            builder: (context, isObscured) {
              return TextFormField(
                obscureText: isObscured,
                validator: Validator.validatePassword,
                controller: context.read<RegisterCubit>().passwordController,
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
          TextFormField(
            validator: Validator.validateMobileNumber,
            controller: context.read<RegisterCubit>().mobileController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter mobile number',
              floatingLabelStyle:
                  Styles.textStyle14Regular.copyWith(color: kPrimaryColor),
              label: const Text(
                'Mobile',
              ),
              focusedBorder: inputDecoration(),
              enabledBorder: inputDecoration(),
              border: inputDecoration(),
            ),
          ),
        ],
      ),
    );
  }
}
