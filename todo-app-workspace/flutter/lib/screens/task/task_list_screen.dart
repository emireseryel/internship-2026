import 'package:flutter/material.dart';
import 'package:flutterproject/data/models/task_model.dart';
import 'package:flutterproject/screens/auth/login_screen.dart';
import 'package:flutterproject/screens/task/widgets/add_task.dart';
import 'package:flutterproject/screens/task/widgets/task_card.dart';
import 'package:flutterproject/state/auth_notifier.dart';
import 'package:flutterproject/state/task_notifier.dart';

class TaskListScreen extends StatefulWidget {
  final AuthNotifier authNotifier;

  const TaskListScreen({super.key, required this.authNotifier});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TaskNotifier _taskNotifier = TaskNotifier();

  @override
  void initState() {
    super.initState();
    _taskNotifier.fetchTasks();
  }

  Future<void> _handleLogout() async {
    await widget.authNotifier.logout();
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => LoginScreen(authNotifier: widget.authNotifier),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleLogout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: _taskNotifier.isLoading,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ValueListenableBuilder<List<TaskModel>>(
            valueListenable: _taskNotifier.tasks,
            builder: (context, tasks, child) {
              if (tasks.isEmpty) {
                return const Center(
                  child: Text('There are no tasks yet. Add a new one!'),
                );
              }

              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskCard(
                    task: task,
                    onToggle: (_) {
                      _taskNotifier.toggleComplete(task.id);
                    },
                    onDelete: () {
                      _taskNotifier.deleteTask(task.id);
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    showDialog(
      context: context,
      builder: (_) => AddTask(
        onAdd: (title, description, priority) {
          _taskNotifier.addTask(
            title,
            description,
            priority,
            null, 
          );
        },
      ),
    );
  },
  child: const Icon(Icons.add),
),
    );
  }
}