// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  username: json['username'] as String,
  id: json['id'] as String?,
  email: json['email'] as String?,
  token: json['token'] as String?,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'id': instance.id,
      'email': instance.email,
      'token': instance.token,
    };
