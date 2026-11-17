import 'dart:async';

abstract class AuthRepository {
  Future<String> login(String email, String password);
}

class FakeAuthRepository implements AuthRepository {
  @override
  Future<String> login(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    if (email.trim().isEmpty || password.trim().isEmpty) {
      throw ArgumentError('Email et mot de passe requis.');
    }
    return 'token-demo';
  }
}
