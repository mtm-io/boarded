// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:boarded/tabs/auth/screens/sign_in_screen.dart';
import 'package:boarded/tabs/auth/screens/sign_up_screen.dart';
import 'package:boarded/tabs/home/screens/home_screen.dart';

class AppRouter {
  final bool _isAuth;

  AppRouter({
    required bool isAuth,
  }) : _isAuth = isAuth;

  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          }),
      GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
          routes: [
            GoRoute(
                path: 'signin',
                builder: (BuildContext context, GoRouterState state) {
                  return const SignUpPage();
                }),
          ]),
    ],
    redirect: (context, state) {
      final bool loggedIn = _isAuth;
      final bool loggingIn =
          state.location == "/login" || state.location == "/login/signin";

      if (!loggedIn && !loggingIn) {
        return "/login";
      }
      if (loggedIn && loggingIn) {
        return "/";
      }

      return null;
    },
  );
}
