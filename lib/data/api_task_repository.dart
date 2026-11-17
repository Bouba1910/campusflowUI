import 'package:campusflow_models/models/task.dart';

import '../core/api_client.dart';
import 'task_repository.dart';

class ApiTaskRepository implements TaskRepository {
  ApiTaskRepository(this._client);

  final ApiClient _client;

  @override
  Future<List<Task>> fetchTasks() async {
    final response = await _client.dio.get<List<dynamic>>('/taches');
    final data = response.data ?? <dynamic>[];
    return data
        .map((json) => Task.fromJson(Map<String, dynamic>.from(json as Map)))
        .toList();
  }

  @override
  Future<Task> createTask(Task task) async {
    final response = await _client.dio.post<Map<String, dynamic>>(
      '/taches',
      data: task.toJson(),
    );
    return Task.fromJson(Map<String, dynamic>.from(response.data!));
  }

  @override
  Future<Task> updateTask(Task task) async {
    final response = await _client.dio.patch<Map<String, dynamic>>(
      '/taches/${task.id}',
      data: task.toJson(),
    );
    return Task.fromJson(Map<String, dynamic>.from(response.data!));
  }

  @override
  Future<void> deleteTask(int id) async {
    await _client.dio.delete<void>('/taches/$id');
  }
}
