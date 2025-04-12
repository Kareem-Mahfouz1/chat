import 'package:chat/core/utils/service_locator.dart';
import 'package:chat/features/auth/data/repos/auth_repo_impl.dart';
import 'package:chat/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:chat/features/auth/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:chat/features/auth/presentation/views/login_view.dart';
import 'package:chat/features/auth/presentation/views/register_view.dart';
import 'package:chat/features/chats/presentation/views/chat_inside_view.dart';
import 'package:chat/features/home/presentation/views/home_view.dart';
import 'package:chat/features/onboarding/on_boarding1.dart';
import 'package:chat/features/onboarding/on_boarding2.dart';
import 'package:chat/features/onboarding/on_boarding3.dart';
import 'package:chat/features/splash/splash_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kOnBoarding1 = '/onBoarding1';
  static const kOnBoarding2 = '/onBoarding2';
  static const kOnBoarding3 = '/onBoarding3';
  static const kRegisterView = '/registerView';
  static const kLoginView = '/loginView';
  static const kHomeView = '/homeView';
  static const kChatInsideView = '/chatInsideView';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/s',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kOnBoarding1,
        builder: (context, state) => const OnBoarding1(),
      ),
      GoRoute(
        path: kOnBoarding2,
        builder: (context, state) => const OnBoarding2(),
      ),
      GoRoute(
        path: kOnBoarding3,
        builder: (context, state) => const OnBoarding3(),
      ),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => BlocProvider(
          create: (context) => RegisterCubit(getIt.get<AuthRepoImpl>()),
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
        path: '/',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: kChatInsideView,
        builder: (context, state) => const ChatInsideView(),
      ),
    ],
  );
}
