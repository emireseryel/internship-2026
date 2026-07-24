import 'package:flutter/material.dart';
import 'package:flutterproject/data/models/task_model.dart';
import 'package:flutterproject/screens/auth/login_screen.dart';
import 'package:flutterproject/screens/task/widgets/add_task.dart';
import 'package:flutterproject/screens/task/widgets/edit_task.dart';
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

  List<TaskModel> _sortTasks(List<TaskModel> originalTasks) {
    List<TaskModel> tasks = List.from(originalTasks);
    tasks.sort((a, b) => b.id.compareTo(a.id));
    return tasks;
  }

  void _openEditSheet(TaskModel task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => EditTask(
        task: task,
        onDelete: () => _taskNotifier.deleteTask(task.id),
        onUpdate: (title, desc, dueAt) {
          _taskNotifier.updateTask(task.id, {
            'title': title,
            'description': desc,
            'due_at': dueAt?.toIso8601String(),
          });
        },
      ),
    );
  }

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

  Widget _buildTaskList(List<TaskModel> allTasks, String filter) {
    List<TaskModel> filteredTasks;

    if (filter == 'active') {
      filteredTasks = allTasks.where((t) => !t.isCompleted).toList();
    } else if (filter == 'completed') {
      filteredTasks = allTasks.where((t) => t.isCompleted).toList();
    } else {
      filteredTasks = allTasks;
    }

    final displayTasks = _sortTasks(filteredTasks);

    if (displayTasks.isEmpty) {
      return RefreshIndicator(
        onRefresh: () => _taskNotifier.fetchTasks(),
        child: ListView(
          children: const [
            SizedBox(height: 200),
            Center(child: Text('Görev bulunamadı.')),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _taskNotifier.fetchTasks(),
      child: ListView.builder(
        itemCount: displayTasks.length,
        itemBuilder: (context, index) {
          final task = displayTasks[index];
          return TaskCard(
            task: task,
            onToggle: (_) => _taskNotifier.toggleComplete(task.id),
            onTap: () => _openEditSheet(task),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Tasks'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _handleLogout,
              tooltip: 'Logout',
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.deepPurple,
            labelColor: Colors.deepPurple,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Hepsi'),
              Tab(text: 'Aktif'),
              Tab(text: 'Tamamlanan'),
            ],
          ),
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
                return TabBarView(
                  children: [
                    _buildTaskList(tasks, 'all'),
                    _buildTaskList(tasks, 'active'),
                    _buildTaskList(tasks, 'completed'),
                  ],
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
                onAdd: (title, description, priority, dueAt) {
                  _taskNotifier.addTask(title, description, priority, dueAt);
                },
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
