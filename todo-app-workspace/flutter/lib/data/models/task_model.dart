class TaskModel {
  final int id;
  final String title;
  final String? description;
  final String priority;
  final DateTime? dueAt;
  final DateTime? completedAt;
  final bool isOverdue;
  bool get isCompleted => completedAt != null;

  TaskModel(this.id, this.title, this.description, this.priority,this.dueAt, this.completedAt, this.isOverdue);

  factory TaskModel.fromJson(Map<String, dynamic> json){
    var id = json['id'];
    var title = json['title'];
    var description = json['description'];
    var priority = json['priority'];
    var dueAt = json['due_at'] != null ? DateTime.parse(json['due_at']) : null;
    var completedAt = json['completed_at'] != null ? 
    DateTime.parse(json['completed_at']) : null;
    var isOverdue = json['is_overdue'] ?? false;

    return TaskModel(id, title, description, priority, dueAt, completedAt, isOverdue);
  }

}
