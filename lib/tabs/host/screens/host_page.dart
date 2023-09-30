import 'package:boarded/core/common/error_text.dart';
import 'package:boarded/core/common/loader.dart';
import 'package:boarded/models/room_model.dart';
import 'package:boarded/tabs/auth/controller/auth_controller.dart';
import 'package:boarded/tabs/home/tamplates/room_card.dart';
import 'package:boarded/tabs/rooms/controller/room_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';

class HostPage extends ConsumerStatefulWidget {
  const HostPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HostPageState();
}

class _HostPageState extends ConsumerState<HostPage> {
  void navigateToCreateRoom(BuildContext context) {
    Routemaster.of(context).push('/create-room');
  }

  void navigateToRoom(BuildContext context, Room room) {
    Routemaster.of(context).push('/room/${room.id}');
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: const Text("Create Room"),
            onPressed: () => navigateToCreateRoom(context),
          ),
          ElevatedButton(
            onPressed: () {
              ref.watch(authControllerProvider.notifier).signOut();
            },
            child: const Text("Sign Out"),
          ),
          ref.watch(userRoomsProvider).when(
                data: (rooms) => Expanded(
                  child: ListView.builder(
                    itemCount: rooms.length,
                    itemBuilder: (BuildContext context, int index) {
                      final room = rooms[index];
                      print(room.name);
                      final String time = DateFormat('E, M.dd, HH:mm').format(room.startDateTime);
                      // TODO: remove
                      List<String> randomImages = [
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaOjCZSoaBhZyODYeQMDCOTICHfz_tia5ay8I_k3k&s',
                        'https://imgv3.fotor.com/images/cover-photo-image/a-beautiful-girl-with-gray-hair-and-lucxy-neckless-generated-by-Fotor-AI.jpg',
                        'https://pixlr.com/images/index/remove-bg.webp',
                        'https://images.pexels.com/photos/4154191/pexels-photo-4154191.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                      ];
                      return RoomCard(
                        title: room.name,
                        time: time,
                        place: room.address,
                        tags: room.games,
                        images: randomImages,
                        onArrowTap: () {
                          navigateToRoom(context, room);
                        },
                        cardColorNum: room.cardColor,
                        key: UniqueKey(),
                      );
                    },
                  ),
                ),
                error: (error, stackTrace) => ErrorText(error: error.toString()),
                loading: () => const Loader(),
              )
        ],
      ),
    );
  }
}
