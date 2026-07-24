import 'package:flutter/material.dart';
import 'package:flutterproject/core/network/dio_client.dart';
import 'package:flutterproject/data/models/task_model.dart';
import 'package:flutterproject/data/services/task_service.dart';

class TaskNotifier {
  final TaskService _taskService;

  TaskNotifier({TaskService? taskService})
      : _taskService = taskService ?? TaskService(DioClient());

  final ValueNotifier<List<TaskModel>> tasks = ValueNotifier<List<TaskModel>>([]);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  Future<void> fetchTasks({String? status}) async {
    isLoading.value = true;
    try {
      final result = await _taskService.getTasks(status: status);
      tasks.value = result;
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addTask(
    String title,
    String? description,
    String? priority,
    DateTime? dueAt,
  ) async {
    try {
      final newTask = await _taskService.createTask(
        title: title,
        description: description,
        priority: priority,
        dueAt: dueAt,
      );
      tasks.value = [newTask, ...tasks.value];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTask(int id, Map<String, dynamic> data) async {
    try {
      final updatedTask = await _taskService.updateTask(id, data);
      tasks.value = tasks.value.map((task) {
        return task.id == id ? updatedTask : task;
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleComplete(int id) async {
    try {
      final updatedTask = await _taskService.toggleComplete(id);
      tasks.value = tasks.value.map((task) {
        return task.id == id ? updatedTask : task;
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await _taskService.deleteTask(id);
      tasks.value = tasks.value.where((task) => task.id != id).toList();
    } catch (e) {
      rethrow;
    }
  }
}