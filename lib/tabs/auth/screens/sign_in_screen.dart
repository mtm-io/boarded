import 'package:boarded/core/common/google_auth_button.dart';
import 'package:boarded/tabs/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signInWithEmailAndPassword(WidgetRef ref, BuildContext context) =>
      ref.read(authControllerProvider).signInWithEmailAndPassword(
            emailAddress: _emailController.text,
            password: _passwordController.text,
            context: context,
          );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Loggin Screen")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: "Password",
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16.0),
            const SignInButton(),
            ElevatedButton(
              onPressed: () => signInWithEmailAndPassword(ref, context),
              child: const Text("Log in"),
            ),
            ElevatedButton(
              onPressed: () {
                return context.go('/login/signin');
              },
              child: const Text("Sign in"),
            ),
          ],
        ),
      ),
    );
  }
}
