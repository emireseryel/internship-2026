import 'package:flutter/material.dart';
import 'package:flutterproject/data/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final Function(bool?) onToggle;
  final VoidCallback onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: onToggle,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: task.description != null && task.description!.isNotEmpty
            ? Text(task.description!)
            : null,
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}