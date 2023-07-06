import 'package:boarded/core/common/google_auth_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Loggin Screen")),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SignInButton(),
        ],
      ),
    );
  }
}
