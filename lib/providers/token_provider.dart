import 'dart:convert';
import 'dart:developer';

import 'package:boarded/main.dart';
import 'package:boarded/providers/secure_storage_provider.dart';
import 'package:dio/dio.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_provider.g.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  return dio;
});

@riverpod
class TokenController extends _$TokenController {
  @override
  Future<String?> build() async {
    final secureStorage = ref.read(secureStorageProvider);

    return await secureStorage.read(key: 'token');
  }

  Future<void> register(String email, String password) async {
    state = const AsyncValue.loading();
    final secureStorage = ref.read(secureStorageProvider);
    try {
      final response = await ref
          .read(dioProvider)
          .post(
            '$baseUrl/register',
            data: {'username': email, 'password': password},
            options: Options(
              headers: {'Content-Type': 'application/json'},
              validateStatus: (status) => true,
            ),

            //options: Options(contentType: Headers.formUrlEncodedContentType),
          );

      if (response.statusCode == 200) {
        final data =
            response.data is String ? jsonDecode(response.data) : response.data;
        final token = data['access_token'];
        await secureStorage.write(key: 'token', value: token);
        state = AsyncValue.data(token);
        log('Registration success: $data');
      } else if (response.statusCode == 400) {
        throw Exception('User already exists');
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
    final secureStorage = ref.read(secureStorageProvider);
    try {
      final response = await ref
          .read(dioProvider)
          .post(
            '$baseUrl/token',
            data: {'username': email, 'password': password},
            options: Options(contentType: Headers.formUrlEncodedContentType),
          );

      if (response.statusCode == 200) {
        final data =
            response.data is String ? jsonDecode(response.data) : response.data;
        final token = data['access_token'];

        await secureStorage.write(key: 'token', value: token);
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
    final secureStorage = ref.read(secureStorageProvider);
    await secureStorage.delete(key: 'token');
    state = const AsyncValue.data(null);
  }
}
