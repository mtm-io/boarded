import 'package:boarded/tabs/auth/screens/login_screen.dart';
import 'package:boarded/tabs/auth/screens/sign_in_screen.dart';
import 'package:boarded/tabs/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        }),
    GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
        routes: [
          GoRoute(
              path: 'signin',
              builder: (BuildContext context, GoRouterState state) {
                return SignUpPage();
              }),
        ]),
  ],
);
