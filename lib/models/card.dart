import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'card.freezed.dart';

part 'card.g.dart';

@freezed
abstract class CardModel with _$CardModel {
  const factory CardModel({
    required String title,
    DateTime? startDate,
    bool? isActive,
    String? hostId,
  }) = _CardModel;

  factory CardModel.fromJson(Map<String, Object?> json) =>
      _$CardModelFromJson(json);
}
