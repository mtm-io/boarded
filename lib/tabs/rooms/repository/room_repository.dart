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
  RoomRepository({required FirebaseFirestore firestore}) : _firestore = firestore;

  FutureVoid createRoom(Room room) async {
    try {
      return right(_rooms.doc(room.id).set(room.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Room>> getUserRooms(String uid) {
    return _rooms.where('members', arrayContains: uid).snapshots().map((event) {
      List<Room> rooms = [];
      for (var doc in event.docs) {
        rooms.add(Room.fromMap(doc.data() as Map<String, dynamic>));
      }
      return rooms;
    });
  }

  Stream<Room> getRoomById(String id) {
    return _rooms.doc(id).snapshots().map((event) => Room.fromMap(event.data() as Map<String, dynamic>));
  }

  CollectionReference get _rooms => _firestore.collection(FirebaseConstants.roomsCollection);
  // CollectionReference get _games => _firestore.collection(FirebaseConstants.gamesCollection);

  // Stream<QuerySnapshot> getBoardGames() {
  //   return _games.snapshots(); //.map((event) => BoardGames.fromMap(event.data() as Map<String, dynamic>));
  // }
}
