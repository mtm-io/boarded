import 'dart:convert';

import 'package:boarded/core/common/snackbars.dart';
import 'package:boarded/models/board_games_model.dart';
import 'package:boarded/models/room_model.dart';
import 'package:boarded/tabs/auth/controller/auth_controller.dart';
import 'package:boarded/tabs/rooms/repository/room_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

final roomControllerProvider =
    StateNotifierProvider<RoomController, bool>((ref) {
  final roomRepository = ref.watch(roomRepositoryProvider);
  return RoomController(roomRepository: roomRepository, ref: ref);
});

class RoomController extends StateNotifier<bool> {
  final RoomRepository _roomRepository;
  final Ref _ref;
  RoomController({required RoomRepository roomRepository, required Ref ref})
      : _roomRepository = roomRepository,
        _ref = ref,
        super(false);

  void createRoom(String name, String description, List<String> games,
      String startDateTime, String address, BuildContext context) async {
    state = true;
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
        startDateTime: startDateTime);

    final res = await _roomRepository.createRoom(room);
    state = false;
    res.fold((l) => showErrorSnackBar(context, l.message), (r) {
      showSuccessSnackBar(context, 'Room created successfully!');
      Routemaster.of(context).pop();
    });
  }

  Stream<QuerySnapshot> getBoardGames() {
    return _roomRepository.getBoardGames();
  }

  Future<List<BoardGames>> getAllCategory(String filter) async {
    final baseUrl =
        "https://api.geekdo.com/xmlapi2/search?query=$filter&type=boardgame&exact=0";
    const hotUrl = "https://api.geekdo.com/xmlapi2/hot?type=boardgame";
    final url = filter.isEmpty ? hotUrl : baseUrl;

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final transformer = Xml2Json();
      transformer.parse(response.body);
      final jsonString = transformer.toGData();
      List<BoardGames> items = [];

      final jsonData = json.decode(jsonString)["items"]['item'] as List;
      for (var element in jsonData) {
        if (filter.isEmpty) {
          // Hot games
          final val = element["name"]['value'];
          final newVal = val.replaceAllMapped(RegExp(r':.+'), (match) {
            return '';
          });
          items.add(BoardGames(name: newVal));
        } else {
          // Search
          if (element["name"]["type"] == "primary") {
            final val = element["name"]['value'];
            final newVal = val.replaceAllMapped(RegExp(r':.+'), (match) {
              return '';
            });
            items.add(BoardGames(name: newVal));
          }
        }
      }

      return items.toSet().toList();
    } else {
      //TODO: Handle Errors
      throw response.statusCode;
    }
  }
}
