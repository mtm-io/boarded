import 'package:boarded/tabs/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class HostPage extends ConsumerWidget {
  const HostPage({Key? key}) : super(key: key);

  void navigateToCreateRoom(BuildContext context) {
    Routemaster.of(context).push('/create-room');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: ElevatedButton(
        child: const Text("Create Room"),
        onPressed: () => navigateToCreateRoom(context),
      ),
    );
  }
}
