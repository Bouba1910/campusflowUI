import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

String defaultApiBaseUrl() {
  if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
    return 'http://localhost:3000';
  }
  return 'http://10.0.2.2:3000';
}

class ApiClient {
  ApiClient({String? baseUrl})
    : dio = Dio(BaseOptions(baseUrl: baseUrl ?? defaultApiBaseUrl())) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _token;
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (response.statusCode == 401) {
            _onUnauthorized?.call();
          }
          handler.next(response);
        },
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            _onUnauthorized?.call();
          }
          handler.next(error);
        },
      ),
    );
  }

  final Dio dio;
  String? _token;
  void Function()? _onUnauthorized;

  void setToken(String? token) {
    _token = token;
  }

  void setOnUnauthorized(void Function() callback) {
    _onUnauthorized = callback;
  }
}
