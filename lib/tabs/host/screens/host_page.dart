import 'package:boarded/core/common/error_text.dart';
import 'package:boarded/core/common/loader.dart';
import 'package:boarded/core/constants/my_text.dart';
import 'package:boarded/models/room_model.dart';
import 'package:boarded/tabs/auth/controller/auth_controller.dart';
import 'package:boarded/tabs/home/tamplates/room_card.dart';
import 'package:boarded/tabs/rooms/controller/room_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';
import 'package:animations/animations.dart';

import '../../../core/constants/constants.dart';
import 'templates/host_card.dart';
import 'templates/opend_card.dart';

class HostPage extends ConsumerStatefulWidget {
  const HostPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HostPageState();
}

class _HostPageState extends ConsumerState<HostPage> {
  //late String user;
  void navigateToCreateRoom(BuildContext context) {
    Routemaster.of(context).push('/create-room');
  }

  void navigateToRoom(BuildContext context, Room room) {
    Routemaster.of(context).push('/room/${room.id}');
  }


  void _scaleDialog() {}

  Widget _dialog(BuildContext context) {
    return AlertDialog(
      title: const Text("Flutter Dev's"),
      content: const Text("FlutterDevs specializes in creating cost-effective "
          "and efficient applications with our perfectly crafted, creative and "
          "leading-edge flutter app development solutions for customers all around "
          "the globe."),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Okay",
              style: TextStyle(color: Colors.red, fontSize: 17),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
      body: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.only(top: 50.0.h, bottom: 20.h),
          //   child: MyText(user.name),
          // ),
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

                    physics: BouncingScrollPhysics(),
                    itemCount: rooms.length,
                    itemBuilder: (BuildContext context, int index) {
                      final room = rooms[index];

                      final String time = DateFormat('E, M.dd, HH:mm')
                          .format(room.startDateTime);
                      // TODO: remove

                      List<String> randomImages = [
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaOjCZSoaBhZyODYeQMDCOTICHfz_tia5ay8I_k3k&s',
                        'https://imgv3.fotor.com/images/cover-photo-image/a-beautiful-girl-with-gray-hair-and-lucxy-neckless-generated-by-Fotor-AI.jpg',
                        'https://pixlr.com/images/index/remove-bg.webp',
                        'https://images.pexels.com/photos/4154191/pexels-photo-4154191.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                      ];

                      return GestureDetector(
                        child: HostCard(
                          title: room.name,
                          time: time,
                          place: room.address,
                          tags: room.games,
                          images: randomImages,
                          onArrowTap: () {
                            navigateToRoom(context, room);
                          },
                          cardColorNum: room.cardColor,
                        ),
                        onTap: () {
                          showGeneralDialog(
                            // barrierColor: Color.fromRGBO(55, 125, 205, 1),
                            barrierDismissible: true,
                            context: context,
                            barrierLabel: "barier",
                            pageBuilder: (ctx, a1, a2) {
                              return Container();
                            },
                            transitionBuilder: (ctx, a1, a2, child) {
                              var curve = Curves.easeInOut.transform(a1.value);
                              return Transform.scale(
                                scale: curve,
                                child: Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(23.0.r),
                                    ),
                                  ),
                                  // shadowColor:
                                  //     Color.fromRGBO(55, 125, 205, 0.4),
                                  backgroundColor: Colors.transparent,
                                  insetPadding: const EdgeInsets.all(0),
                                  child: OpendCard(
                                    title: room.name,
                                    time: time,
                                    place: room.address,
                                    tags: room.games,
                                    images: randomImages,
                                    onArrowTap: () {},
                                    cardColorNum: room.cardColor,
                                  ),
                                ),
                              );
                            },
                            transitionDuration:
                                const Duration(milliseconds: 200),
                          );
                        },

                      );
                    },
                  ),
                ),
                error: (error, stackTrace) =>
                    ErrorText(error: error.toString()),
                loading: () => const Loader(),
              )
        ],
      ),
    );
  }
}
