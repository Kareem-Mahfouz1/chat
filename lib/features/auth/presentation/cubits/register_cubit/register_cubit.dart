import 'package:chat/features/auth/data/repos/auth_repo_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_cubit_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authRepoImpl) : super(RegisterInitial());
  final AuthRepoImpl authRepoImpl;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      emit(RegisterLoading());
      final result = await authRepoImpl.register(
          emailController.text, passwordController.text);
      result.fold(
        (failure) {
          emit(RegisterFailure(errMessage: failure.errMessage));
        },
        (userCredential) {
          emit(RegisterSuccess(userCredential: userCredential));
        },
      );
    }
  }
}
