import 'dart:convert';
import 'dart:developer';

import 'package:boarded/main.dart';
import 'package:boarded/providers/dio_provider.dart';
import 'package:boarded/providers/secure_storage_provider.dart';
import 'package:dio/dio.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_provider.g.dart';

const accessTokenKey = 'access_token';
const refreshTokenKey = 'refresh_token';

@riverpod
class TokenController extends _$TokenController {
  @override
  Future<String?> build() async {
    final secureStorage = ref.read(secureStorageProvider);

    return await secureStorage.read(key: accessTokenKey);
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
        final accessToken = data['access_token'];
        final refreshToken = data['refresh_token'];
        await secureStorage.write(key: accessTokenKey, value: accessToken);
        await secureStorage.write(key: refreshTokenKey, value: refreshToken);
        state = AsyncValue.data(accessToken);
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
        final accessToken = data['access_token'];
        final refreshToken = data['refresh_token'];
        await secureStorage.write(key: accessTokenKey, value: accessToken);
        await secureStorage.write(key: refreshTokenKey, value: refreshToken);
        state = AsyncValue.data(accessToken);
        log(
          'Login success! Access token: $accessToken, Refresh token: $refreshToken',
        );
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
    await secureStorage.delete(key: accessTokenKey);
    await secureStorage.delete(key: refreshTokenKey);
    state = const AsyncValue.data(null);
  }

  Future<void> setToken(String token) async {
    final secureStorage = ref.read(secureStorageProvider);
    state = AsyncValue.data(token);
    await secureStorage.write(key: accessTokenKey, value: token);
  }
}
