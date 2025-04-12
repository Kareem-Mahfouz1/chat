import 'package:chat/features/auth/data/repos/auth_repo_impl.dart';
import 'package:chat/features/auth/data/repos/user_repo_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AuthRepoImpl>(AuthRepoImpl());
  getIt.registerSingleton<UserRepoImpl>(UserRepoImpl());
}
