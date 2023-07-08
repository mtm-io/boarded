import 'package:boarded/core/common/google_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Loggin Screen")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SignInButton(),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Log in"),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/login/signin');
            },
            child: const Text("Sign in"),
          ),
        ],
      ),
    );
  }
}
