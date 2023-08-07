// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateRoomScreen extends ConsumerStatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends ConsumerState<CreateRoomScreen> {
  final roomNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    roomNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Text('Room name'),
          const SizedBox(
            height: 10.0,
          ),
          TextField(
            controller: roomNameController,
            decoration: const InputDecoration(
              hintText: 'A fun evening playing Monopoly',
              fillColor: Color.fromARGB(255, 255, 255, 255),
              filled: true,
              border: InputBorder.none,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Create'),
          )
        ]),
      ),
    );
  }
}
