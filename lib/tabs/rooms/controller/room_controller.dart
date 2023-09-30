import 'dart:convert';
import 'dart:math';

import 'package:boarded/core/common/snackbars.dart';
import 'package:boarded/core/constants/constants.dart';
import 'package:boarded/models/board_games_model.dart';
import 'package:boarded/models/room_model.dart';
import 'package:boarded/tabs/auth/controller/auth_controller.dart';
import 'package:boarded/tabs/rooms/repository/room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

final userRoomsProvider = StreamProvider((ref) {
  final roomController = ref.watch(roomControllerProvider.notifier);
  return roomController.getUserRooms();
});

final roomControllerProvider =
    StateNotifierProvider<RoomController, bool>((ref) {
  final roomRepository = ref.watch(roomRepositoryProvider);
  return RoomController(roomRepository: roomRepository, ref: ref);
});

//final getRoomByNameProvider = StreamProvider.family((ref, String id) {
//  return ref.watch(roomControllerProvider.notifier).getRoomById(id);
//});

class RoomController extends StateNotifier<bool> {
  final RoomRepository _roomRepository;
  final Ref _ref;
  RoomController({required RoomRepository roomRepository, required Ref ref})
      : _roomRepository = roomRepository,
        _ref = ref,
        super(false);

  void createRoom(String name, String description, List<String> games,
      DateTime startDateTime, String address, BuildContext context) async {
    state = true;
    // Beta Dummy veritification
    // TODO: make a valid verification with custom errors for every field
    // e.g. "Room description can't be null!"

    final uid = _ref.read(userProvider)?.uid ?? '';
    Room room = Room(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        description: description,
        city: address,
        address: address,
        members: [uid],
        admin: [uid],
        games: games,
        pfps: [],
        cardColor: Random().nextInt(Constants.cardColors.length),
        startDateTime: startDateTime);

    final res = await _roomRepository.createRoom(room);
    state = false;
    res.fold((l) => showErrorSnackBar(context, l.message), (r) {
      showSuccessSnackBar(context, 'Room created successfully!');
      Routemaster.of(context).pop();
    });
  }

  // Stream<QuerySnapshot> getBoardGames() {
  //   return _roomRepository.getBoardGames();
  // }

  Stream<List<Room>> getUserRooms() {
    final uid = _ref.read(userProvider)!.uid;
    //print("HEEEEEAAAAARRRRR:   " + uid);
    return _roomRepository.getUserRooms(uid);
  }

  // Stream<Room> getRoomById(String id) {
  //   return _roomRepository.getRoomById(id);
  // }

  Future<List<BoardGames>> getAllCategory(String filter) async {
    final baseUrl =
        "https://api.geekdo.com/xmlapi2/search?query=$filter&type=boardgame&exact=0";
    // const hotUrl = "https://api.geekdo.com/xmlapi2/hot?type=boardgame";
    // final url = filter.isEmpty ? hotUrl : baseUrl;

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final transformer = Xml2Json();
      transformer.parse(response.body);
      final jsonString = transformer.toGData();
      List<BoardGames> items = [];

      final jsonData = json.decode(jsonString)["items"]['item'] as List;
      for (var element in jsonData) {
        // if (filter.isEmpty) {
        //   // Hot games
        //   final val = element["name"]['value'];
        //   final newVal = val.replaceAllMapped(RegExp(r':.+'), (match) {
        //     return '';
        //   });
        //   items.add(BoardGames(name: newVal));
        // } else {
        // Search
        if (element["name"]["type"] == "primary") {
          final val = element["name"]['value'];
          if (val.toLowerCase().startsWith(filter.toLowerCase().trim())) {
            print(filter.toLowerCase().split(' ').length);
            final newVal = val.replaceAllMapped(RegExp(r':.+'), (match) {
              return '';
            });
            items.add(BoardGames(name: newVal));
          }
        }
        // }
      }
      items = items.toSet().toList();
      items.sort((a, b) =>
          a.name.split(' ').length.compareTo(b.name.split(' ').length));
      print(items.length);
      return items;
    } else {
      //TODO: Handle Errors
      throw response.statusCode;
    }
  }
}
