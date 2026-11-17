import 'dart:async';

import 'package:campusflow_models/models/task.dart';

import 'task_repository.dart';

class FakeTaskRepository implements TaskRepository {
  FakeTaskRepository([List<Task>? tasks])
    : _tasks = List<Task>.unmodifiable(tasks ?? _initialTasks),
      _nextId =
          (tasks ?? _initialTasks).fold<int>(
            0,
            (max, task) => task.id > max ? task.id : max,
          ) +
          1;

  static final _initialTasks = [
    Task(
      id: 1,
      title: 'Rendre le TP Flutter',
      description: 'Finaliser les écrans et vérifier la navigation.',
      dueDate: DateTime(2026, 11, 20),
    ),
    Task(
      id: 2,
      title: 'Réviser les widgets',
      description: 'Revoir les widgets de mise en page pour le contrôle.',
      dueDate: DateTime(2026, 11, 6),
    ),
    Task(
      id: 3,
      title: 'Préparer la démonstration',
      description: 'Préparer les étapes de démonstration sur tablette.',
      dueDate: DateTime(2026, 11, 24),
    ),
    Task(
      id: 4,
      title: 'Rendre le compte rendu',
      description: 'Le compte rendu du projet a été déposé.',
      dueDate: DateTime(2026, 11, 4),
      isCompleted: true,
    ),
  ];

  List<Task> _tasks;
  int _nextId;

  @override
  Future<List<Task>> fetchTasks() async {
    await _delay();
    return List<Task>.of(_tasks);
  }

  @override
  Future<Task> createTask(Task task) async {
    await _delay();
    final created = task.copyWith(id: _nextId++);
    _tasks = List<Task>.of(_tasks)..add(created);
    return created;
  }

  @override
  Future<Task> updateTask(Task task) async {
    await _delay();
    final index = _tasks.indexWhere((item) => item.id == task.id);
    if (index == -1) {
      throw StateError('Tâche introuvable : ${task.id}');
    }
    final updated = _tasks[index].copyWith(
      title: task.title,
      description: task.description,
      dueDate: task.dueDate,
      isCompleted: task.isCompleted,
    );
    final next = List<Task>.of(_tasks);
    next[index] = updated;
    _tasks = next;
    return updated;
  }

  @override
  Future<void> deleteTask(int id) async {
    await _delay();
    _tasks = _tasks.where((task) => task.id != id).toList();
  }

  Future<void> _delay() {
    return Future<void>.delayed(const Duration(milliseconds: 120));
  }
}
