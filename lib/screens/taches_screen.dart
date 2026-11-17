import 'package:campusflow_models/models/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../state/filters.dart';
import '../state/tasks_notifier.dart';
import '../utils/date_format.dart';
import '../widgets/tache_detail_body.dart';

class TachesScreen extends ConsumerStatefulWidget {
  const TachesScreen({super.key, required this.filter});

  final TaskFilter filter;

  @override
  ConsumerState<TachesScreen> createState() => _TachesScreenState();
}

class _TachesScreenState extends ConsumerState<TachesScreen> {
  int? _selectedId;

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(filteredTasksProvider(widget.filter));

    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth >= 840;
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
          data: (tasks) =>
              isTablet ? _tabletLayout(tasks) : _list(tasks, false),
        );
      },
    );
  }

  Widget _tabletLayout(List<Task> tasks) {
    final selected = tasks.where((task) => task.id == _selectedId).toList();

    return Row(
      children: [
        Expanded(flex: 2, child: _list(tasks, true)),
        const VerticalDivider(width: 1),
        Expanded(
          flex: 3,
          child: selected.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'Aucune tâche sélectionnée.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : _detail(selected.first),
        ),
      ],
    );
  }

  Widget _list(List<Task> tasks, bool isTablet) {
    if (tasks.isEmpty) {
      return Center(child: Text(_emptyMessage()));
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        final titleStyle = task.isCompleted
            ? TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              )
            : null;

        return Column(
          children: [
            ListTile(
              selected: isTablet && task.id == _selectedId,
              title: Text(task.title, style: titleStyle),
              subtitle: Text('À rendre le ${formatDueDate(task.dueDate)}'),
              onTap: () {
                if (isTablet) {
                  setState(() => _selectedId = task.id);
                } else {
                  context.go('/taches/${task.id}');
                }
              },
            ),
            if (index < tasks.length - 1) const Divider(height: 1),
          ],
        );
      },
    );
  }

  Widget _detail(Task task) {
    return TacheDetailBody(
      task: task,
      onTerminer: () async {
        await ref.read(tasksProvider.notifier).setCompleted(task.id, true);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Tâche terminée.')));
        }
      },
      onSupprimer: () async {
        await ref.read(tasksProvider.notifier).removeTask(task.id);
        if (mounted) {
          setState(() => _selectedId = null);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Tâche supprimée.')));
        }
      },
    );
  }

  String _emptyMessage() {
    return switch (widget.filter) {
      TaskFilter.aFaire => 'Aucune tâche à faire.',
      TaskFilter.faites => 'Aucune tâche terminée.',
      TaskFilter.enRetard => 'Aucune tâche en retard.',
    };
  }
}
