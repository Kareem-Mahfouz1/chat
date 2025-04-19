import 'package:chat/constants.dart';
import 'package:chat/core/utils/input_border.dart';
import 'package:chat/core/utils/styles.dart';
import 'package:chat/core/utils/validators.dart';
import 'package:chat/core/widgets/custom_loading_indicator.dart';
import 'package:chat/features/contacts/presentation/cubits/add_contact_cubit/add_contact_cubit.dart';
import 'package:chat/features/contacts/presentation/cubits/contacts_cubit/contacts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddContactDialog extends StatelessWidget {
  const AddContactDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddContactCubit>();
    return BlocConsumer<AddContactCubit, AddContactState>(
      listener: (context, state) {
        if (state is AddContactFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
            ),
          );
        } else if (state is AddContactSuccess) {
          Navigator.pop(context);
          context.read<ContactsCubit>().getContacts();
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: const Text("Add Contact"),
          content: Form(
            key: cubit.formKey,
            child: state is AddContactLoading
                ? const Center(child: CustomLoadingIndicator())
                : TextFormField(
                    controller: cubit.phoneController,
                    keyboardType: TextInputType.phone,
                    validator: Validator.validateMobileNumber,
                    decoration: InputDecoration(
                      hintText: 'Enter mobile number',
                      floatingLabelStyle: Styles.textStyle14Regular
                          .copyWith(color: kPrimaryColor),
                      label: const Text(
                        'Mobile',
                      ),
                      focusedBorder: inputDecoration(),
                      enabledBorder: inputDecoration(),
                      border: inputDecoration(),
                    ),
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await cubit.tryAddContact();
              },
              child: const Text(
                "Add",
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
