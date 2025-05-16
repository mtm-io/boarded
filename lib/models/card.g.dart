// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CardModel _$CardModelFromJson(Map<String, dynamic> json) => _CardModel(
  title: json['title'] as String,
  startDate:
      json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
  isActive: json['isActive'] as bool?,
  hostId: json['hostId'] as String?,
);

Map<String, dynamic> _$CardModelToJson(_CardModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'startDate': instance.startDate?.toIso8601String(),
      'isActive': instance.isActive,
      'hostId': instance.hostId,
    };
