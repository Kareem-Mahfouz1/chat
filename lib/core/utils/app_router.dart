import 'package:chat/core/utils/service_locator.dart';
import 'package:chat/features/auth/data/repos/auth_repo_impl.dart';
import 'package:chat/core/services/user_repo_impl.dart';
import 'package:chat/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:chat/features/auth/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:chat/features/auth/presentation/views/login_view.dart';
import 'package:chat/features/auth/presentation/views/register_view.dart';
import 'package:chat/features/chats/data/models/chat_model.dart';
import 'package:chat/features/chats/data/repos/chats_repo_impl.dart';
import 'package:chat/features/chats/data/repos/messages_repo_impl.dart';
import 'package:chat/features/chats/presentation/cubits/chats_cubit/chats_cubit.dart';
import 'package:chat/features/chats/presentation/cubits/messages_cubit/messages_cubit.dart';
import 'package:chat/features/chats/presentation/views/chat_inside_view.dart';
import 'package:chat/features/chats/presentation/views/start_chat_view.dart';
import 'package:chat/features/contacts/data/repos/contacts_repo_impl.dart';
import 'package:chat/features/contacts/presentation/cubits/contacts_cubit/contacts_cubit.dart';
import 'package:chat/features/home/presentation/views/home_view.dart';
import 'package:chat/features/onboarding/cubits/on_boarding_cubit.dart';
import 'package:chat/features/onboarding/on_boarding.dart';
import 'package:chat/features/settings/presentation/cubits/settings_cubit/settings_cubit.dart';
import 'package:chat/features/settings/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:chat/features/splash/splash_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kOnBoardingView = '/onBoardingView';
  static const kRegisterView = '/registerView';
  static const kLoginView = '/loginView';
  static const kHomeView = '/homeView';
  static const kChatInsideView = '/chatInsideView';
  static const kStartChatView = '/startChatView';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kOnBoardingView,
        builder: (context, state) => BlocProvider(
          create: (context) => OnBoardingCubit(),
          child: const OnBoarding(),
        ),
      ),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => BlocProvider(
          create: (context) => RegisterCubit(
              getIt.get<AuthRepoImpl>(), getIt.get<UserRepoImpl>()),
          child: const RegisterView(),
        ),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => BlocProvider(
          create: (context) => LoginCubit(getIt.get<AuthRepoImpl>()),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => ChatsCubit(
                (getIt.get<ChatsRepoImpl>()),
              )..streamUserChats(),
            ),
            BlocProvider(
              create: (_) => ContactsCubit(
                (getIt.get<ContactsRepoImpl>()),
              )..getContacts(),
            ),
            BlocProvider(
              create: (_) => UserCubit(
                (getIt.get<UserRepoImpl>()),
              )..loadUser(),
            ),
            BlocProvider(
              create: (_) => SettingsCubit(
                (getIt.get<UserRepoImpl>()),
              ),
            ),
          ],
          child: const HomeView(),
        ),
      ),
      GoRoute(
        path: kStartChatView,
        builder: (context, state) => BlocProvider(
          create: (_) => ContactsCubit(
            (getIt.get<ContactsRepoImpl>()),
          )..getContacts(),
          child: const StartChatView(),
        ),
      ),
      GoRoute(
        path: kChatInsideView,
        builder: (context, state) => BlocProvider(
          create: (context) => MessagesCubit(getIt.get<MessageRepoImpl>())
            ..streamMessages((state.extra as ChatModel).chatId),
          child: ChatInsideView(chatModel: state.extra as ChatModel),
        ),
      ),
    ],
  );
}
