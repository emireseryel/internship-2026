import 'package:flutterproject/core/constants/api_constants.dart';
import 'package:flutterproject/core/network/dio_client.dart';
import 'package:flutterproject/data/models/task_model.dart';

class TaskService {
  final DioClient _dioClient;

  TaskService(this._dioClient);

  Future<List<TaskModel>> getTasks({String? status}) async {
    final response = await _dioClient.dio.get(
      ApiConstants.tasks,
      queryParameters: {'status': status},
    );
    final List<dynamic> taskList = response.data['data'];
    return taskList
        .map((json) => TaskModel.fromJson(json))
        .toList();
  }

  Future<TaskModel> createTask({
    required String title,
    String? description,
    String? priority,
    DateTime? dueAt,
  }) async {
    final response = await _dioClient.dio.post(
      ApiConstants.tasks,
      data: {
        'title': title,
        'description': description,
        'priority': priority ?? 'medium',
        'due_at': dueAt?.toIso8601String(),
      },
    );

    return TaskModel.fromJson(response.data['data']);
  }

  Future<TaskModel> updateTask(int id, Map<String, dynamic> data) async {
    final response = await _dioClient.dio.put(
      '${ApiConstants.tasks}/$id',
      data: data,
    );

    return TaskModel.fromJson(response.data['data']);
  }

  Future<void> deleteTask(int id) async{
    await _dioClient.dio.delete(
      '${ApiConstants.tasks}/$id',
    );
  }

  Future<TaskModel> toggleComplete(int id) async{
    final response = await _dioClient.dio.patch(
      '${ApiConstants.tasks}/$id/complete',
    );
    return TaskModel.fromJson(response.data['data']);
  }
}
