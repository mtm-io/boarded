import 'dart:developer';

import 'package:boarded/models/user.dart';
import 'package:boarded/pages/home_page.dart';
import 'package:boarded/pages/login_page.dart';
import 'package:boarded/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EntryPage extends ConsumerWidget {
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    AsyncValue<UserModel?> user = ref.watch(userControllerProvider);
    return user.when(
      data:
          (value) => value == null ? const LoginPage() : HomePage(user: value),
      loading:
          () =>
              Scaffold(body: Center(child: const CircularProgressIndicator())),
      error: (error, stack) {
        log('UserController error: $error');
        return const Scaffold(
          body: Center(child: Text('Oops, something unexpected happened')),
        );
      },
    );
  }
}
