import 'package:chat/constants.dart';
import 'package:chat/core/utils/input_border.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:chat/core/utils/validators.dart';
import 'package:flutter/material.dart';

class EditFields extends StatelessWidget {
  const EditFields(
      {super.key,
      required this.nameController,
      required this.phoneController,
      required this.formKey});
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          spacing: 38,
          children: [
            TextFormField(
              controller: nameController,
              validator: Validator.validateName,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: 'Enter your name',
                floatingLabelStyle:
                    Styles.textStyle14Regular.copyWith(color: kPrimaryColor),
                label: const Text('Name'),
                focusedBorder: inputDecoration(),
                enabledBorder: inputDecoration(),
                border: inputDecoration(),
              ),
            ),
            TextFormField(
              controller: phoneController,
              validator: Validator.validateMobileNumber,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter your mobile',
                floatingLabelStyle:
                    Styles.textStyle14Regular.copyWith(color: kPrimaryColor),
                label: const Text('Phone'),
                focusedBorder: inputDecoration(),
                enabledBorder: inputDecoration(),
                border: inputDecoration(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
