import 'package:chat/features/settings/presentation/views/widgets/info_card.dart';
import 'package:chat/features/settings/presentation/views/widgets/settings_appbar.dart';
import 'package:chat/features/settings/presentation/views/widgets/settings_item.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          SettingsAppbar(),
          SizedBox(height: 15),
          InfoCard(),
          SizedBox(height: 30),
          SettingsItem(
            text: 'Edit Profile',
            icon: Icons.edit_outlined,
          ),
          SizedBox(height: 20),
          SettingsItem(
            text: 'Delete account',
            icon: Icons.delete_outline,
          ),
          SizedBox(height: 20),
          SettingsItem(
            text: 'Logout',
            icon: Icons.logout_outlined,
          ),
        ],
      ),
    );
  }
}
