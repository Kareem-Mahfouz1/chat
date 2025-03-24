part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterFailure extends RegisterState {
  final String errMessage;

  RegisterFailure({required this.errMessage});
}

final class RegisterSuccess extends RegisterState {
  final UserCredential userCredential;

  RegisterSuccess({required this.userCredential});
}
