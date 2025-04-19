import 'package:chat/core/models/contact.dart';
import 'package:chat/features/contacts/data/repos/contacts_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit(this.contactsRepoImpl) : super(ContactsInitial());
  final ContactsRepoImpl contactsRepoImpl;

  Future<void> getContacts() async {
    emit(ContactsLoading());
    final result = await contactsRepoImpl.getContacts();
    result.fold(
      (failure) {
        emit(ContactsFailure(errMessage: failure.errMessage));
      },
      (contacts) {
        emit(ContactsSuccess(contacts: contacts));
      },
    );
  }
}
