import 'package:campusflow_models/models/task.dart';

abstract class TaskRepository {
  Future<List<Task>> fetchTasks();

  Future<Task> createTask(Task task);

  Future<Task> updateTask(Task task);

  Future<void> deleteTask(int id);
}
