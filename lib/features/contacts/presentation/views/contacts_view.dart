import 'package:chat/constants.dart';
import 'package:chat/core/utils/service_locator.dart';
import 'package:chat/core/widgets/custom_loading_indicator.dart';
import 'package:chat/core/widgets/empty_list.dart';
import 'package:chat/features/contacts/data/repos/contacts_repo_impl.dart';
import 'package:chat/features/contacts/presentation/cubits/add_contact_cubit/add_contact_cubit.dart';
import 'package:chat/features/contacts/presentation/cubits/contacts_cubit/contacts_cubit.dart';
import 'package:chat/features/contacts/presentation/views/widgets/add_contact_dialog.dart';
import 'package:chat/features/contacts/presentation/views/widgets/contact_item.dart';
import 'package:chat/features/contacts/presentation/views/widgets/contacts_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ContactsAppbar(),
          const SizedBox(height: 15),
          Expanded(
            child: BlocBuilder<ContactsCubit, ContactsState>(
              builder: (context, state) {
                if (state is ContactsFailure) {
                  return Center(child: Text(state.errMessage));
                } else if (state is ContactsSuccess) {
                  return state.contacts.isEmpty
                      ? const EmptyListIndicator(text: 'No contacts yet')
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          itemCount: state.contacts.length,
                          itemBuilder: (context, index) {
                            return ContactItem(
                              name: state.contacts[index].name,
                            );
                          },
                        );
                } else if (state is ContactsLoading) {
                  return const CustomLoadingIndicator();
                } else {
                  return const Center(child: Text('initial'));
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'CONTACTS_FAB',
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: Icon(MdiIcons.accountPlusOutline),
        onPressed: () {
          final contactsCubit = context.read<ContactsCubit>();
          showDialog(
            context: context,
            builder: (context) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        AddContactCubit(getIt.get<ContactsRepoImpl>()),
                  ),
                  BlocProvider.value(
                    value: contactsCubit,
                  ),
                ],
                child: const AddContactDialog(),
              );
            },
          );
        },
      ),
    );
  }
}
