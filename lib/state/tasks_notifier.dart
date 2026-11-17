import 'package:campusflow_models/models/task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';

final tasksProvider = AsyncNotifierProvider<TasksNotifier, List<Task>>(
  TasksNotifier.new,
);

class TasksNotifier extends AsyncNotifier<List<Task>> {
  @override
  Future<List<Task>> build() {
    return ref.read(taskRepositoryProvider).fetchTasks();
  }

  Future<void> addTask(Task task) async {
    final created = await ref.read(taskRepositoryProvider).createTask(task);
    final current = state.value ?? <Task>[];
    state = AsyncValue.data([...current, created]);
  }

  Future<void> setCompleted(int id, bool value) async {
    final current = state.value ?? <Task>[];
    final index = current.indexWhere((task) => task.id == id);
    if (index == -1) {
      return;
    }
    final updated = await ref
        .read(taskRepositoryProvider)
        .updateTask(current[index].copyWith(isCompleted: value));
    state = AsyncValue.data([
      for (final task in current) task.id == id ? updated : task,
    ]);
  }

  Future<void> removeTask(int id) async {
    await ref.read(taskRepositoryProvider).deleteTask(id);
    final current = state.value ?? <Task>[];
    state = AsyncValue.data(current.where((task) => task.id != id).toList());
  }
}
