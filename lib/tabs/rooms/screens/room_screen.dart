// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:boarded/core/common/error_text.dart';
import 'package:boarded/core/common/loader.dart';
import 'package:boarded/tabs/auth/controller/auth_controller.dart';
import 'package:boarded/tabs/rooms/controller/room_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class RoomScreen extends ConsumerWidget {
  final String name;
  const RoomScreen({
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Container(
        child: ref.watch(getRoomByNameProvider(name)).when(
              data: (room) => Scaffold(
                appBar: AppBar(title: Text(room.name)),
                body: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(room.address),
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
                    room.admin.contains(user.uid)
                        ? ElevatedButton(
                            onPressed: () {},
                            child: Text('Edit'),
                          )
                        : ElevatedButton(
                            onPressed: () {},
                            child: Text(room.members.contains(user.uid) ? 'Joined' : 'Join'),
                          ),
                  ],
                ),
              ),
              error: (error, stackTrace) => ErrorText(error: error.toString()),
              loading: () => const Loader(),
            ));
  }
}
