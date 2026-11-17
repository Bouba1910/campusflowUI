import 'package:dio/dio.dart';

class ApiClient {
  ApiClient({String baseUrl = 'http://10.0.2.2:3000'})
    : dio = Dio(BaseOptions(baseUrl: baseUrl)) {
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
