import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/api_client.dart';
import '../core/secure_token_storage.dart';
import '../data/api_task_repository.dart';
import '../data/auth_repository.dart';
import '../data/task_repository.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final secureTokenStorageProvider = Provider<SecureTokenStorage>(
  (ref) => SecureTokenStorage(),
);

final taskRepositoryProvider = Provider<TaskRepository>(
  (ref) => ApiTaskRepository(ref.read(apiClientProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => FakeAuthRepository(),
);

final tokenProvider = NotifierProvider<TokenNotifier, String?>(
  () => TokenNotifier(),
);

class TokenNotifier extends Notifier<String?> {
  TokenNotifier([this._initialToken]);

  final String? _initialToken;

  @override
  String? build() => _initialToken;

  void set(String? token) {
    state = token;
  }
}
