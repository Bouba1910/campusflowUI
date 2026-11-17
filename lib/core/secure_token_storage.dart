import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureTokenStorage {
  SecureTokenStorage({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  static const _key = 'campusflow_token';

  final FlutterSecureStorage _storage;

  Future<String?> readToken() async {
    return _storage.read(key: _key);
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: _key, value: token);
  }

  Future<void> clearToken() async {
    await _storage.delete(key: _key);
  }
}
