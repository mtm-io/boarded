// import 'package:boarded/core/common/error_text.dart';
// import 'package:boarded/core/common/loader.dart';
// import 'package:boarded/tabs/rooms/controller/room_controller.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class EditRoomScreen extends ConsumerStatefulWidget {
//   final String id;
//   const EditRoomScreen({super.key, required this.id});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _EditRoomScreenState();
// }

// class _EditRoomScreenState extends ConsumerState<EditRoomScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return ref.watch(getRoomByNameProvider(widget.id)).when(
//           data: (data) => Scaffold(
//             appBar: AppBar(
//               title: const Text('Edit room'),
//               centerTitle: false,
//               actions: [
//                 TextButton(
//                   onPressed: () {},
//                   child: const Text('Save'),
//                 ),
//               ],
//             ),
//             body: Column(
//               children: [
//                 DottedBorder(
//                   child: Container(
//                     width: double.infinity,
//                     height: 150,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           error: (error, stackTrace) => ErrorText(error: error.toString()),
//           loading: () => const Loader(),
//         );
//   }
// }
