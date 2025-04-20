import 'package:chat/core/models/user_model.dart';
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
import 'package:chat/features/settings/presentation/views/edit_profile_view.dart';
import 'package:chat/features/splash/splash_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kOnBoardingView = '/onBoardingView';
  static const kRegisterView = '/registerView';
  static const kLoginView = '/loginView';
  static const kHomeView = '/homeView';
  static const kChatInsideView = '/chatInsideView';
  static const kStartChatView = '/startChatView';
  static const kEditProfileView = '/editProfileView';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kOnBoardingView,
        pageBuilder: (context, state) => AppRouter.buildSlideTransition(
          child: BlocProvider(
            create: (context) => OnBoardingCubit(),
            child: const OnBoarding(),
          ),
        ),
      ),
      GoRoute(
        path: kRegisterView,
        pageBuilder: (context, state) => AppRouter.buildSlideTransition(
          child: BlocProvider(
            create: (context) => RegisterCubit(
                getIt.get<AuthRepoImpl>(), getIt.get<UserRepoImpl>()),
            child: const RegisterView(),
          ),
        ),
      ),
      GoRoute(
        path: kLoginView,
        pageBuilder: (context, state) => AppRouter.buildSlideTransition(
          child: BlocProvider(
            create: (context) => LoginCubit(getIt.get<AuthRepoImpl>()),
            child: const LoginView(),
          ),
        ),
      ),
      GoRoute(
        path: kEditProfileView,
        pageBuilder: (context, state) => AppRouter.buildSlideTransition(
          child: BlocProvider(
            create: (context) => SettingsCubit(getIt.get<UserRepoImpl>()),
            child: EditProfileView(user: state.extra as UserModel),
          ),
        ),
      ),
      GoRoute(
        path: kHomeView,
        pageBuilder: (context, state) => AppRouter.buildFadeTransition(
          child: MultiBlocProvider(
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
      ),
      GoRoute(
        path: kStartChatView,
        pageBuilder: (context, state) => AppRouter.buildSlideTransition(
          child: BlocProvider(
            create: (_) => ContactsCubit(
              (getIt.get<ContactsRepoImpl>()),
            )..getContacts(),
            child: const StartChatView(),
          ),
        ),
      ),
      GoRoute(
        path: kChatInsideView,
        pageBuilder: (context, state) => AppRouter.buildSlideTransition(
          child: BlocProvider(
            create: (context) => MessagesCubit(getIt.get<MessageRepoImpl>())
              ..streamMessages((state.extra as ChatModel).chatId),
            child: ChatInsideView(chatModel: state.extra as ChatModel),
          ),
        ),
      ),
    ],
  );
  static CustomTransitionPage<T> buildSlideTransition<T>({
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  static CustomTransitionPage<T> buildFadeTransition<T>({
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      transitionDuration: const Duration(milliseconds: 250),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
