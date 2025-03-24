import 'package:chat/features/auth/data/repos/auth_repo_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepoImpl) : super(LoginInitial());
  final AuthRepoImpl authRepoImpl;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoading());
      final result = await authRepoImpl.login(
          emailController.text, passwordController.text);
      result.fold(
        (failure) {
          emit(LoginFailure(errMessage: failure.errMessage));
        },
        (userCredential) {
          emit(LoginSuccess(userCredential: userCredential));
        },
      );
    }
  }
}
