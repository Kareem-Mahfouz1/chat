import 'package:chat/core/widgets/custom_loading_indicator.dart';
import 'package:chat/core/widgets/empty_list.dart';
import 'package:chat/features/contacts/presentation/cubits/contacts_cubit/contacts_cubit.dart';
import 'package:chat/features/contacts/presentation/views/widgets/contact_item.dart';
import 'package:chat/features/contacts/presentation/views/widgets/contacts_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                            return const ContactItem();
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
    );
  }
}
