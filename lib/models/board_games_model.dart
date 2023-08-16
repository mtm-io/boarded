// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BoardGames {
  final String name;
  BoardGames({
    required this.name,
  });

  BoardGames copyWith({
    String? name,
  }) {
    return BoardGames(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory BoardGames.fromMap(Map<String, dynamic> map) {
    return BoardGames(
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BoardGames.fromJson(String source) => BoardGames.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BoardGames(name: $name)';

  @override
  bool operator ==(covariant BoardGames other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
