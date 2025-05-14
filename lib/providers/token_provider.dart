import 'dart:convert';
import 'dart:developer';

import 'package:boarded/main.dart';
import 'package:boarded/providers/secure_storage_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as ss;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_provider.g.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  return dio;
});

@riverpod
class TokenController extends _$TokenController {
  late final ss.FlutterSecureStorage _secureStorage;
  late final Dio _dio;
  @override
  Future<String?> build() async {
    _secureStorage = ref.read(secureStorageProvider);
    _dio = ref.read(dioProvider);

    return await _secureStorage.read(key: 'token');
  }

  Future<void> register(String email, String password) async {
    state = const AsyncValue.loading();

    try {
      final response = await _dio.post(
        '$baseUrl/fake_register',
        data: {'username': email, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
        //options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (response.statusCode == 200) {
        final data =
            response.data is String ? jsonDecode(response.data) : response.data;
        log('Registration success: $data');
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      log('Login failed: $e');
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();

    try {
      final response = await _dio.post(
        '$baseUrl/token',
        data: {'username': email, 'password': password},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (response.statusCode == 200) {
        final data =
            response.data is String ? jsonDecode(response.data) : response.data;
        final token = data['access_token'];

        await _secureStorage.write(key: 'token', value: token);
        state = AsyncValue.data(token);
        log('Login success: $token');
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      log('Login failed: $e');
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'token');
    state = const AsyncValue.data(null);
  }
}
