// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Room {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final List<String> members;
  final List<String> admin;
  final List<String> games;
  final List<String> pfps;
  final int cardColor;
  final DateTime startDateTime;
  Room({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.members,
    required this.admin,
    required this.games,
    required this.pfps,
    required this.cardColor,
    required this.startDateTime,
  });

  Room copyWith({
    String? id,
    String? name,
    String? description,
    String? city,
    String? address,
    List<String>? members,
    List<String>? admin,
    List<String>? games,
    List<String>? pfps,
    int? cardColor,
    DateTime? startDateTime,
  }) {
    return Room(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      city: city ?? this.city,
      address: address ?? this.address,
      members: members ?? this.members,
      admin: admin ?? this.admin,
      games: games ?? this.games,
      pfps: pfps ?? this.pfps,
      cardColor: cardColor ?? this.cardColor,
      startDateTime: startDateTime ?? this.startDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'city': city,
      'address': address,
      'members': members,
      'admin': admin,
      'games': games,
      'pfps': pfps,
      'cardColor': cardColor,
      'startDateTime': startDateTime.millisecondsSinceEpoch,
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      city: map['city'] as String,
      address: map['address'] as String,
      members: List<String>.from(map['members']),
      admin: List<String>.from(map['admin']),
      games: List<String>.from(map['games']),
      pfps: List<String>.from(map['pfps']),
      cardColor: map['cardColor'] as int,
      startDateTime: DateTime.fromMillisecondsSinceEpoch(map['startDateTime'] as int),
    );
  }

  @override
  String toString() {
    return 'Room(id: $id, name: $name, description: $description, city: $city, address: $address, members: $members, admin: $admin, games: $games, pfps: $pfps, cardColor: $cardColor, startDateTime: $startDateTime)';
  }

  @override
  bool operator ==(covariant Room other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.city == city &&
        other.address == address &&
        listEquals(other.members, members) &&
        listEquals(other.admin, admin) &&
        listEquals(other.games, games) &&
        listEquals(other.pfps, pfps) &&
        other.cardColor == cardColor &&
        other.startDateTime == startDateTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        city.hashCode ^
        address.hashCode ^
        members.hashCode ^
        admin.hashCode ^
        games.hashCode ^
        pfps.hashCode ^
        cardColor.hashCode ^
        startDateTime.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(String source) => Room.fromMap(json.decode(source) as Map<String, dynamic>);
}
