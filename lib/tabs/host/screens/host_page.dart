import 'package:boarded/tabs/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HostPage extends ConsumerStatefulWidget {
  const HostPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HostPageState();
}

class _HostPageState extends ConsumerState<HostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Host"),
      ),
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
