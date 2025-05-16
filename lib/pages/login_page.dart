import 'dart:developer';

import 'package:boarded/models/user.dart';
import 'package:boarded/providers/token_provider.dart';
import 'package:boarded/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:
                  () => ref
                      .read(tokenControllerProvider.notifier)
                      .login("cat", "cat"),
              child: const Text("Login"),
            ),
            ElevatedButton(
              onPressed:
                  () => ref
                      .read(tokenControllerProvider.notifier)
                      .register("cat", "cat"),
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
