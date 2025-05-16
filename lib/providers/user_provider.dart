import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:boarded/main.dart';
import 'package:boarded/models/user.dart';
import 'package:boarded/providers/token_provider.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
class UserController extends _$UserController {
  @override
  Future<UserModel?> build() async {
    Dio dio = ref.read(dioProvider);
    final token = await ref.watch(tokenControllerProvider.future);
    if (token == null) return null;
    log('token: $token');
    final response = await dio.get(
      '$baseUrl/users/me',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
        validateStatus: (status) => true,
      ),
    );
    log('response: $response');
    if (response.statusCode == 200) {
      log(UserModel.fromJson(response.data).toString());
      return UserModel.fromJson(response.data);
    } else if (response.statusCode == 401) {
      log('401');
      // ref.read(tokenControllerProvider.notifier).logout();
      return null;
    } else {
      log('Failed to fetch user');
      throw Exception('Failed to fetch user');
    }
  }
}
