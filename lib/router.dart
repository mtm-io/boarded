// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:boarded/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:boarded/tabs/auth/screens/sign_in_screen.dart';

class AppRouter {
  /// a Property that comes from the Stream in main.dart
  /// if the user logged in or not
  final bool _isAuth;

  AppRouter({
    required bool isAuth,
  }) : _isAuth = isAuth;

  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(

          /// home route
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const BottomNavigator();
          }),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
    ],
    redirect: (context, state) {
      final bool loggedIn = _isAuth;

      /// if the /login or /login/signin will be open
      /// loggingIn will be set to true
      final bool loggingIn = state.location == "/login";

      /// redirects unlogged user when
      /// /login or /login/signin not will be open
      if (!loggedIn && !loggingIn) {
        return "/login";
      }

      /// redirects logged user to home
      /// when he goes to loggin page
      if (loggedIn && loggingIn) {
        return "/";
      }

      return null;
    },
  );
}
