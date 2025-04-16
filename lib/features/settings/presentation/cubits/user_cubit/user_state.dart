part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserFailure extends UserState {
  final String errMessage;
  UserFailure({required this.errMessage});
}

final class UserSucess extends UserState {
  final UserModel user;
  UserSucess({required this.user});
}
