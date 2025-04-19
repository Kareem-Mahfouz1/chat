import 'package:chat/features/contacts/data/repos/contacts_repo_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_contact_state.dart';

class AddContactCubit extends Cubit<AddContactState> {
  AddContactCubit(this.contactsRepo) : super(AddContactInitial());
  final ContactsRepoImpl contactsRepo;
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> tryAddContact() async {
    if (formKey.currentState!.validate()) {
      emit(AddContactLoading());
      phoneController.text.trim();
      final result =
          await contactsRepo.addContactByPhoneNumber(phoneController.text);
      result.fold(
        (failure) {
          emit(AddContactFailure(errMessage: failure.errMessage));
        },
        (_) {
          emit(AddContactSuccess());
        },
      );
    }
  }
}
