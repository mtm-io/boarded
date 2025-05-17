import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:boarded/main.dart';
import 'package:boarded/models/card.dart';
import 'package:boarded/models/user.dart';
import 'package:boarded/providers/dio_provider.dart';
import 'package:boarded/providers/token_provider.dart';
import 'package:boarded/providers/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cards_provider.g.dart';

@riverpod
class CardsController extends _$CardsController {
  @override
  Future<List<CardModel?>> build() async {
    final user = await ref.watch(userControllerProvider.future);
    if (user == null) return [];
    final token = await ref.watch(tokenControllerProvider.future);
    if (token == null) return [];

    final response = await ref
        .read(dioProvider)
        .get(
          '$baseUrl/cards/get_all',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
            validateStatus: (status) => true,
          ),
        );
    if (response.statusCode == 200) {
      log(response.data.toString());
      return (response.data as List<dynamic>)
          .map((e) => CardModel.fromJson(e))
          .toList();
    }
    return [];
  }
}
