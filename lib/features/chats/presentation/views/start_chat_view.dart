import 'package:chat/core/utils/app_router.dart';
import 'package:chat/core/widgets/custom_loading_indicator.dart';
import 'package:chat/core/widgets/empty_list.dart';
import 'package:chat/features/chats/data/repos/chats_repo_impl.dart';
import 'package:chat/features/chats/presentation/views/widgets/start_chat_appbar.dart';
import 'package:chat/features/contacts/presentation/cubits/contacts_cubit/contacts_cubit.dart';
import 'package:chat/features/contacts/presentation/views/widgets/contact_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class StartChatView extends StatelessWidget {
  const StartChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const StartChatAppbar(),
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
                              onTap: () async {
                                final chatModel = await ChatsRepoImpl()
                                    .getOrCreateChat(
                                        state.contacts[index].phoneNumber);
                                chatModel.fold((l) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(l.errMessage),
                                    ),
                                  );
                                }, (r) {
                                  if (context.mounted) {
                                    context.push(AppRouter.kChatInsideView,
                                        extra: r);
                                  }
                                });
                              },
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
    );
  }
}
