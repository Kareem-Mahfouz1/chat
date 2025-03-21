import 'package:chat/constants.dart';
import 'package:chat/core/utils/input_border.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  const LoginField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Enter your number',
        floatingLabelStyle:
            Styles.textStyle14Regular.copyWith(color: kPrimaryColor),
        label: const Text(
          'Phone',
        ),
        focusedBorder: inputDecoration(),
        enabledBorder: inputDecoration(),
        border: inputDecoration(),
      ),
    );
  }
}
