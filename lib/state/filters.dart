import 'package:campusflow_models/models/task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'tasks_notifier.dart';

enum TaskFilter { aFaire, faites, enRetard }

final filteredTasksProvider =
    Provider.family<AsyncValue<List<Task>>, TaskFilter>((ref, filter) {
      final tasks = ref.watch(tasksProvider);
      return tasks.whenData((value) {
        switch (filter) {
          case TaskFilter.aFaire:
            return value.where((task) => !task.isCompleted).toList();
          case TaskFilter.faites:
            return value.where((task) => task.isCompleted).toList();
          case TaskFilter.enRetard:
            return value
                .where(
                  (task) =>
                      !task.isCompleted &&
                      task.dueDate.isBefore(DateTime.now()),
                )
                .toList();
        }
      });
    });
