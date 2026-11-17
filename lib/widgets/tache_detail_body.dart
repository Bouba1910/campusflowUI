import 'package:campusflow_models/models/task.dart';
import 'package:flutter/material.dart';

import '../utils/date_format.dart';

class TacheDetailBody extends StatelessWidget {
  const TacheDetailBody({
    super.key,
    required this.task,
    required this.onTerminer,
    required this.onSupprimer,
  });

  final Task task;
  final VoidCallback onTerminer;
  final VoidCallback onSupprimer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            color: theme.colorScheme.surfaceContainerLow,
            shape: shape,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title, style: theme.textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text(
                    task.isCompleted ? 'Terminée' : 'À faire',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            color: theme.colorScheme.surfaceContainerLow,
            shape: shape,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(task.description),
                  const SizedBox(height: 16),
                  Text('Échéance', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(formatDueDate(task.dueDate)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: task.isCompleted ? null : onTerminer,
            child: Text(task.isCompleted ? 'Tâche terminée' : 'Marquer comme fait'),
          ),
          TextButton(
            onPressed: onSupprimer,
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }
}
