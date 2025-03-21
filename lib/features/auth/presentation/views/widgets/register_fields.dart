import 'package:chat/constants.dart';
import 'package:chat/core/utils/input_border.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:flutter/material.dart';

class RegisterFields extends StatelessWidget {
  const RegisterFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 28,
      children: [
        TextFormField(
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
        TextFormField(
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
    );
  }
}
