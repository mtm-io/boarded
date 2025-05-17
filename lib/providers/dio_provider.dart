import 'dart:developer';

import 'package:boarded/main.dart';
import 'package:boarded/providers/secure_storage_provider.dart';
import 'package:boarded/providers/token_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.interceptors.add(
    InterceptorsWrapper(
      // onRequest: (options, handler) async {
      //   final token = await ref.read(tokenControllerProvider.future);
      //   if (token != null) {
      //     options.headers['Authorization'] = 'Bearer $token';
      //   }
      //   return handler.next(options);
      // },
      onError: (DioException err, handler) async {
        if (err.response?.statusCode == 401) {
          log('401 interceptor');
          final secureStorage = ref.read(secureStorageProvider);

          final refreshToken = await secureStorage.read(key: refreshTokenKey);
          final response = await dio.post(
            '$baseUrl/refresh',
            data: {'refresh_token': refreshToken},
          );

          if (response.statusCode == 200) {
            final newAccessToken = response.data['access_token'];
            log('New access token: $newAccessToken');
            // Save new token
            await ref
                .read(tokenControllerProvider.notifier)
                .setToken(newAccessToken);

            // Retry original request with new token
            // final opts = err.requestOptions;
            // opts.headers['Authorization'] = 'Bearer $newAccessToken';
            // final cloneReq = await dio.fetch(opts);

            // return handler.resolve(cloneReq);
          } else {
            // Refresh failed, force logout
            ref.read(tokenControllerProvider.notifier).logout();
            return handler.reject(err);
          }
        }

        return handler.next(err);
      },
    ),
  );
  return dio;
});
