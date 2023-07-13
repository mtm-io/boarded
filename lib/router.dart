// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:boarded/tabs/profile/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:boarded/tabs/auth/screens/sign_in_screen.dart';
import 'package:boarded/tabs/auth/screens/sign_up_screen.dart';
import 'package:boarded/tabs/home/screens/home_screen.dart';

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
            return const HomePage();
          }),
      GoRoute(

          /// profile  route
          path: '/profile',
          builder: (BuildContext context, GoRouterState state) {
            return ProfilePage();
          }),
      GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
          routes: [
            GoRoute(

                /// subroute of /login
                /// to go to signin: /login/signin
                path: 'signin',
                builder: (BuildContext context, GoRouterState state) {
                  return const SignUpPage();
                }),
          ]),
    ],
    redirect: (context, state) {
      final bool loggedIn = _isAuth;

      /// if the /login or /login/signin will be open
      /// loggingIn will be set to true
      final bool loggingIn =
          state.location == "/login" || state.location == "/login/signin";

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
