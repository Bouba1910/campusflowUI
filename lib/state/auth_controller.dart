import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';

final authControllerProvider = Provider<AuthController>(
  (ref) => AuthController(ref),
);

class AuthController {
  AuthController(this._ref);

  final Ref _ref;

  Future<void> login(String email, String password) async {
    final token = await _ref
        .read(authRepositoryProvider)
        .login(email, password);
    await _ref.read(secureTokenStorageProvider).saveToken(token);
    _ref.read(tokenProvider.notifier).set(token);
    _ref.read(apiClientProvider).setToken(token);
  }

  Future<void> logout() async {
    await _ref.read(secureTokenStorageProvider).clearToken();
    _ref.read(tokenProvider.notifier).set(null);
    _ref.read(apiClientProvider).setToken(null);
  }
}
