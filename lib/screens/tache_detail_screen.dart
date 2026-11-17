import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../state/tasks_notifier.dart';
import '../widgets/tache_detail_body.dart';

class TacheDetailScreen extends ConsumerWidget {
  const TacheDetailScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksProvider);

    return tasksAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Chargement impossible.'),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => ref.invalidate(tasksProvider),
              child: const Text('Réessayer'),
            ),
          ],
        ),
      ),
      data: (tasks) {
        final found = tasks.where((task) => task.id == id).toList();
        if (found.isEmpty) {
          return const Center(child: Text('Tâche introuvable.'));
        }
        return TacheDetailBody(
          task: found.first,
          onTerminer: () async {
            await ref.read(tasksProvider.notifier).setCompleted(id, true);
            if (context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Tâche terminée.')));
            }
          },
          onSupprimer: () async {
            await ref.read(tasksProvider.notifier).removeTask(id);
            if (context.mounted) {
              context.go('/taches');
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Tâche supprimée.')));
            }
          },
        );
      },
    );
  }
}
