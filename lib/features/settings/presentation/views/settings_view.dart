import 'package:chat/core/utils/app_router.dart';
import 'package:chat/core/widgets/custom_loading_indicator.dart';
import 'package:chat/features/settings/presentation/cubits/settings_cubit/settings_cubit.dart';
import 'package:chat/features/settings/presentation/views/widgets/confirmation_dialog.dart';
import 'package:chat/features/settings/presentation/views/widgets/info_card.dart';
import 'package:chat/features/settings/presentation/views/widgets/settings_appbar.dart';
import 'package:chat/features/settings/presentation/views/widgets/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is SettingsFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          } else if (state is SettingsSuccess) {
            GoRouter.of(context).go(AppRouter.kRegisterView);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is SettingsLoading,
            progressIndicator: const CustomLoadingIndicator(),
            child: Column(
              spacing: 5,
              children: [
                const SettingsAppbar(),
                const SizedBox(height: 5),
                const InfoCard(),
                const SizedBox(height: 20),
                SettingsItem(
                  text: 'Edit Profile',
                  icon: Icons.edit_outlined,
                  onTap: () {
                    // TODO
                    // GoRouter.of(context).go(AppRouter.kEditProfileView);
                  },
                ),
                SettingsItem(
                  text: 'Delete Account',
                  icon: Icons.delete_outline,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const ConfirmationDialog(),
                    );
                  },
                ),
                SettingsItem(
                  text: 'Logout',
                  icon: Icons.logout_outlined,
                  onTap: () {
                    context.read<SettingsCubit>().logout();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
