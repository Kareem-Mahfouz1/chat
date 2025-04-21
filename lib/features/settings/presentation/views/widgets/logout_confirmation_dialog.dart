import 'package:chat/constants.dart';
import 'package:chat/features/settings/presentation/cubits/settings_cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kBackgroundColor,
      title: const Text("Logout"),
      content: const Text("Are you sure you want to logout?"),
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
            context.read<SettingsCubit>().logout();
          },
          child: const Text("Logout", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
