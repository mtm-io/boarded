import 'package:boarded/core/common/loader.dart';
import 'package:boarded/models/board_games_model.dart';
import 'package:boarded/tabs/rooms/controller/room_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

class CreateRoomScreen extends ConsumerStatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends ConsumerState<CreateRoomScreen> {
  final roomNameController = TextEditingController();
  final roomDecriptionController = TextEditingController();
  final roomGamesController = TextEditingController();
  final roomAddressController = TextEditingController();
  final roomDateController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    roomNameController.dispose();
    roomDecriptionController.dispose();
    roomGamesController.dispose();
    roomAddressController.dispose();
    roomDateController.dispose();
  }

  void createRoom() {
    ref.read(roomControllerProvider.notifier).createRoom(
          roomNameController.text.trim(),
          roomDecriptionController.text.trim(),
          roomGamesController.text.trim().split(' '),
          roomDateController.text.trim(),
          roomAddressController.text.trim(),
          context,
        );
  }

  Future<List<BoardGames>> getData(filter) async {
    var boardGamesList = await ref.read(roomControllerProvider.notifier).getAllCategory(filter);
    return boardGamesList;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(roomControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a room'),
      ),
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  Text('Room name'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: roomNameController,
                    decoration: const InputDecoration(
                      hintText: 'Board evening @ ArtDecoCowork',
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text('Room description'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: roomDecriptionController,
                    decoration: const InputDecoration(
                      hintText: 'A fun evening playing Monopoly, bring friends!',
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text('Board games you want to play'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // If firebase Query:
                  //
                  // StreamBuilder<QuerySnapshot>(
                  //   stream: ref.read(roomControllerProvider.notifier).getBoardGames(),
                  //   builder: (context, snapshot) {
                  //     List<BoardGames> boardGamesItems = [];
                  //     if (!snapshot.hasData) {
                  //       const Loader();
                  //     } else {
                  //       final boardGames = snapshot.data?.docs.toList();
                  //       for (var game in boardGames!) {
                  //         boardGamesItems.add(BoardGames(id: game['id'], name: game['name']));
                  //       }
                  //     }
                  //     return ???; // <- Widget
                  //   },
                  // ),
                  //
                  ////////////////////////////////////////////////////////////////
                  //
                  // Working Dropdown
                  DropdownSearch<BoardGames>.multiSelection(
                    asyncItems: (filter) => getData(filter),
                    itemAsString: (BoardGames b) => b.name,
                    compareFn: (i, s) => i == s,
                    popupProps: PopupPropsMultiSelection.modalBottomSheet(
                      isFilterOnline: true,
                      showSelectedItems: true,
                      showSearchBox: true,
                      itemBuilder: _popupItemBuilder,
                    ),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: "Modal mode",
                        hintText: "Select an Int",
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),

                  ///
                  /// TODO: TRY TO MAKE OK UI
                  ///
                  DropdownSearch<String>(
                    items: List.generate(5, (index) => "$index"),
                    popupProps: PopupProps.modalBottomSheet(
                      fit: FlexFit.loose,
                      modalBottomSheetProps: ModalBottomSheetProps(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      containerBuilder: (ctx, popupWidget) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Image.asset(
                                'assets/images/google.png',
                                color: Color(0xFF2F772A),
                                height: 12,
                              ),
                            ),
                            Flexible(
                              child: Container(
                                child: popupWidget,
                                color: Color(0xFF2F772A),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text('Adress'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: roomAddressController,
                    decoration: const InputDecoration(
                      hintText: '5th Avenue, 25',
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text('Date'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: roomDateController,
                    decoration: const InputDecoration(
                      hintText: '18.10.2023 @ 18:00',
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
            ),
    );
  }

  Widget _popupItemBuilder(BuildContext context, BoardGames item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      // decoration: !isSelected
      //     ? null
      //     : BoxDecoration(
      //         border: Border.all(color: Theme.of(context).primaryColor),
      //         borderRadius: BorderRadius.circular(5),
      //         color: Colors.white,
      //       ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.name),
        // subtitle: Text(item.createdAt.toString()),
        // leading: CircleAvatar(
        //   backgroundImage: NetworkImage(item.avatar),
        // ),
      ),
    );
  }
}
