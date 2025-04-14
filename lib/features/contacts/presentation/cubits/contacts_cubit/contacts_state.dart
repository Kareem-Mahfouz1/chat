part of 'contacts_cubit.dart';

@immutable
sealed class ContactsState {}

final class ContactsInitial extends ContactsState {}

final class ContactsLoading extends ContactsState {}

final class ContactsFailure extends ContactsState {
  final String errMessage;
  ContactsFailure({required this.errMessage});
}

final class ContactsSuccess extends ContactsState {
  final List<Contact> contacts;
  ContactsSuccess({required this.contacts});
}
