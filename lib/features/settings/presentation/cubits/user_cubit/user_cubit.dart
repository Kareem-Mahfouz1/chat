import 'package:chat/core/models/user_model.dart';
import 'package:chat/core/services/user_repo_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepo) : super(UserInitial());
  final UserRepoImpl userRepo;
  late UserModel user;
  Future<void> loadUser() async {
    emit(UserLoading());
    final result = await userRepo.getCurrentUser();

    result.fold(
      (failure) => emit(UserFailure(errMessage: failure.errMessage)),
      (user) {
        emit(UserSucess(user: user));
        this.user = user;
      },
    );
  }
}
