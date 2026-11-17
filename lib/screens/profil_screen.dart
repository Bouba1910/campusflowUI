import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../state/auth_controller.dart';

class ProfilScreen extends ConsumerWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Profil de l\'étudiant'),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () async {
                await ref.read(authControllerProvider).logout();
                if (context.mounted) {
                  context.go('/login');
                }
              },
              child: const Text('Se déconnecter'),
            ),
          ],
        ),
      ),
    );
  }
}
