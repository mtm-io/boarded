import 'package:collection/collection.dart';

class UserModel {
  final String name;
  final String email;
  final String profilePic;
  final String uid;
  final String isAuthenticated;
  final List<String> hostedRooms;
  final List<String> joinedRooms;
  UserModel({
    required this.name,
    required this.email,
    required this.profilePic,
    required this.uid,
    required this.isAuthenticated,
    required this.hostedRooms,
    required this.joinedRooms,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? profilePic,
    String? banner,
    String? uid,
    String? isAuthenticated,
    List<String>? hostedRooms,
    List<String>? joinedRooms,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      uid: uid ?? this.uid,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      hostedRooms: hostedRooms ?? this.hostedRooms,
      joinedRooms: joinedRooms ?? this.joinedRooms,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'profilePic': profilePic,
      'uid': uid,
      'isAuthenticated': isAuthenticated,
      'hostedRooms': hostedRooms,
      'joinedRooms': joinedRooms,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      profilePic: map['profilePic'] as String,
      uid: map['uid'] as String,
      isAuthenticated: map['isAuthenticated'] as String,
      hostedRooms: List<String>.from(map['hostedRooms'] as List<String>),
      joinedRooms: List<String>.from(map['joinedRooms'] as List<String>),
    );
  }

  // String toJson() => json.encode(toMap());

  // factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, profilePic: $profilePic, uid: $uid, isAuthenticated: $isAuthenticated, hostedRooms: $hostedRooms, joinedRooms: $joinedRooms)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.name == name &&
        other.email == email &&
        other.profilePic == profilePic &&
        other.uid == uid &&
        other.isAuthenticated == isAuthenticated &&
        listEquals(other.hostedRooms, hostedRooms) &&
        listEquals(other.joinedRooms, joinedRooms);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        profilePic.hashCode ^
        uid.hashCode ^
        isAuthenticated.hashCode ^
        hostedRooms.hashCode ^
        joinedRooms.hashCode;
  }
}
