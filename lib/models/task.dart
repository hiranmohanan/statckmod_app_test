part of 'models.dart';

class Task {
  String? id;
  String title;
  String description;
  String dueDate;
  String priority; // "High", "Medium", "Low"
  String status; // "Pending", "In Progress", "Completed"

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'priority': priority,
      'status': status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: map['dueDate'].toString(),
      priority: map['priority'],
      status: map['status'],
    );
  }
  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? dueDate,
    String? priority,
    String? status,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      status: status ?? this.status,
    );
  }
}
