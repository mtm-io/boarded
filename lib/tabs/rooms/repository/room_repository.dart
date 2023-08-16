import 'package:boarded/core/constants/firebase_constants.dart';
import 'package:boarded/core/failure.dart';
import 'package:boarded/core/providers/firebase_providers.dart';
import 'package:boarded/core/type_defs.dart';
import 'package:boarded/models/room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final roomRepositoryProvider = Provider((ref) {
  return RoomRepository(firestore: ref.watch(firestoreProvider));
});

class RoomRepository {
  final FirebaseFirestore _firestore;
  RoomRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  FutureVoid createRoom(Room room) async {
    try {
      // Beta Dummy veritification
      // TODO: make a valid verification with custom errors for every field
      // e.g. "Room description can't be null!"
      if (room.name.length < 5 ||
          room.description.length < 5 ||
          room.games.isEmpty ||
          room.address.length < 5 ||
          room.startDateTime.length < 3) {
        print(room);
        throw 'Enter all the fields!';
      }
      return right(_rooms.doc(room.id).set(room.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  CollectionReference get _rooms =>
      _firestore.collection(FirebaseConstants.roomsCollection);
  CollectionReference get _games =>
      _firestore.collection(FirebaseConstants.gamesCollection);

  Stream<QuerySnapshot> getBoardGames() {
    return _games
        .snapshots(); //.map((event) => BoardGames.fromMap(event.data() as Map<String, dynamic>));
  }
}
