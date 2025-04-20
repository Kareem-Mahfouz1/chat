import 'package:chat/constants.dart';
import 'package:chat/core/models/user_model.dart';
import 'package:chat/core/widgets/custom_loading_indicator.dart';
import 'package:chat/core/widgets/my_button.dart';
import 'package:chat/features/settings/presentation/cubits/settings_cubit/settings_cubit.dart';
import 'package:chat/features/settings/presentation/views/widgets/edit_fields.dart';
import 'package:chat/features/settings/presentation/views/widgets/edit_profile_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key, required this.user});
  final UserModel user;

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    nameController.text = widget.user.displayName;
    phoneController.text = widget.user.phoneNumber;
    super.initState();
  }

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
            GoRouter.of(context).pop();
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is SettingsLoading,
            progressIndicator: const CustomLoadingIndicator(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const EditProfileAppbar(),
                  const SizedBox(height: 45),
                  EditFields(
                    formKey: formKey,
                    nameController: nameController,
                    phoneController: phoneController,
                  ),
                  const SizedBox(height: 120),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kHorizontalPadding),
                    child: SizedBox(
                      width: double.infinity,
                      child: MyButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final UserModel newUser = UserModel(
                              uid: widget.user.uid,
                              displayName: nameController.text,
                              phoneNumber: phoneController.text,
                              email: widget.user.email,
                              contacts: widget.user.contacts,
                            );
                            await context
                                .read<SettingsCubit>()
                                .updateProfile(newUser);
                          }
                        },
                        text: 'Update Profile',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
