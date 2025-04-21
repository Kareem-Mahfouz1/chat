import 'package:chat/constants.dart';
import 'package:chat/features/settings/presentation/cubits/settings_cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAccountConfirmationDialog extends StatelessWidget {
  const DeleteAccountConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kBackgroundColor,
      title: const Text("Delete Account"),
      content: const Text(
          "Are you sure you want to delete your account? This action cannot be undone."),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Cancel
          child: const Text(
            "Cancel",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<SettingsCubit>().deleteAccount();
          },
          child: const Text("Delete", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
