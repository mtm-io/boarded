import 'package:boarded/tabs/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              return context.go('/login');
            },
            child: const Text("Sign in"),
          ),
          ElevatedButton(
            onPressed: () {
              ref.watch(authControllerProvider).signOut();
            },
            child: const Text("Sign Out"),
          ),
        ],
      ),
    );
  }
}
