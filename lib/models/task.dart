enum TaskStatus {
  todo,
  inProgress,
  done
}

enum TaskPriority {
  low,
  medium,
  high
}

class Task {

  final String id;
  final String title;
  final String description;
  final String projectId;
  final TaskStatus status;
  final TaskPriority priority;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.projectId,
    this.status = TaskStatus.todo,
    this.priority = TaskPriority.medium,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? projectId,
    TaskStatus? status,
    TaskPriority? priority,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      projectId: projectId ?? this.projectId,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
    );
  }

}