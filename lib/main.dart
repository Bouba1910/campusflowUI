import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/secure_token_storage.dart';
import 'state/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = SecureTokenStorage();
  final token = await storage.readToken();

  runApp(
    ProviderScope(
      overrides: [
        secureTokenStorageProvider.overrideWithValue(storage),
        tokenProvider.overrideWith(() => TokenNotifier(token)),
      ],
      child: const CampusFlowApp(),
    ),
  );
}
