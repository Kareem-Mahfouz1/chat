import 'package:chat/core/services/notification_service.dart';
import 'package:chat/features/auth/data/repos/auth_repo_impl.dart';
import 'package:chat/core/services/user_repo_impl.dart';
import 'package:chat/features/chats/data/repos/chats_repo_impl.dart';
import 'package:chat/features/chats/data/repos/messages_repo_impl.dart';
import 'package:chat/features/contacts/data/repos/contacts_repo_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<AuthRepoImpl>(AuthRepoImpl());
  getIt.registerSingleton<UserRepoImpl>(UserRepoImpl());
  getIt.registerSingleton<ChatsRepoImpl>(ChatsRepoImpl());
  getIt.registerSingleton<ContactsRepoImpl>(ContactsRepoImpl());
  getIt.registerSingleton<MessageRepoImpl>(MessageRepoImpl());
  getIt.registerLazySingleton<NotificationService>(() => NotificationService());
}
