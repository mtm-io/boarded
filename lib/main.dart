import 'dart:developer';
import 'dart:io';

import 'package:boarded/models/user.dart';
import 'package:boarded/providers/token_provider.dart';
import 'package:boarded/providers/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final String baseUrl =
    Platform.isAndroid ? 'http://10.0.2.2:8000' : 'http://127.0.0.1:8000';
void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<UserModel?> user = ref.watch(userControllerProvider);
    // log('user: $user');
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => {setState(() {})},
                child: const Text('Login'),
              ),
              user.when(
                data: (value) => Text('User: ${value?.username}'),
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) {
                  log('UserController error: $error');
                  return const Text('Oops, something unexpected happened');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
