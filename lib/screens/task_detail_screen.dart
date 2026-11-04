import 'package:flutter/material.dart';

import '../models/task.dart';
import '../utils/date_format.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({
    super.key,
    required this.task,
    required this.onCompleted,
  });

  final Task task;
  final ValueChanged<int> onCompleted;

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late Task _task = widget.task;

  void _markCompleted() {
    setState(() {
      _task = _task.copyWith(isCompleted: true);
    });
    widget.onCompleted(_task.id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Échéance terminée.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Échéance')),
      body: TaskDetailView(
        task: _task,
        onMarkCompleted: _task.isCompleted ? null : _markCompleted,
      ),
    );
  }
}

class TaskDetailView extends StatelessWidget {
  const TaskDetailView({
    super.key,
    required this.task,
    this.onMarkCompleted,
  });

  final Task task;
  final VoidCallback? onMarkCompleted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardShape = RoundedRectangleBorder(
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
            shape: cardShape,
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
            shape: cardShape,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(task.description),
                  const SizedBox(height: 16),
                  Text('Date limite', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(formatDueDate(task.dueDate)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: task.isCompleted ? null : onMarkCompleted,
            child: Text(
              task.isCompleted ? 'Échéance terminée' : 'Marquer comme faite',
            ),
          ),
        ],
      ),
    );
  }
}
