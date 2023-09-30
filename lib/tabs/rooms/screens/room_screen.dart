// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:boarded/core/common/error_text.dart';
import 'package:boarded/core/common/loader.dart';
import 'package:boarded/tabs/auth/controller/auth_controller.dart';
import 'package:boarded/tabs/rooms/controller/room_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class RoomScreen extends ConsumerStatefulWidget {
  final String name;
  const RoomScreen({
    required this.name,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoomScreenState();
}

class _RoomScreenState extends ConsumerState<RoomScreen> {
  late String name = widget.name;
  final roomNameController = TextEditingController();
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    print(user);
    return Container(
        child: ref.watch(getRoomByNameProvider(name)).when(
              data: (room) => Scaffold(
                appBar: AppBar(title: Text(room.name)),
                body: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: roomNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the name';
                        } else if (value.length < 5) {
                          return 'The name is too short';
                        } else if (value.length > 20) {
                          return 'The name is too long';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Board evening @ ArtDecoCowork',
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(DateFormat('E, M.dd, HH:mm').format(room.startDateTime)),
                    SizedBox(
                      height: 20,
                    ),
                    Text(room.description),
                    SizedBox(
                      height: 20,
                    ),
                    isEditing
                        ? ElevatedButton(
                            onPressed: () => {},
                            child: const Text('Save'),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              isEditing = true;
                            },
                            child: const Text('Edit'),
                          ),
                  ],
                ),
              ),
              error: (error, stackTrace) => ErrorText(error: error.toString()),
              loading: () => const Loader(),
            ));
  }
}
