import 'package:chat/core/services/user_repo_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.userRepo) : super(SettingsInitial());
  final UserRepoImpl userRepo;
  Future<void> deleteAccount() async {
    emit(SettingsLoading());
    final result = await userRepo.deleteUserAccount();
    result.fold(
      (failure) => emit(SettingsFailure(errMessage: failure.errMessage)),
      (_) => emit(SettingsSuccess()),
    );
  }

  Future<void> logout() async {
    emit(SettingsLoading());
    await userRepo.logout();
    emit(SettingsSuccess());
  }
}
