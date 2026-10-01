import 'package:cloud_firestore/cloud_firestore.dart';

enum Priority { low, medium, high }

class Task {
  Task(
    this.title,
    this.description,
    this.time,
    this.category,
    this.priority, {
    this.id = '',
    this.date = '',
    this.completed = false,
  });

  String id;
  String title;
  String description;
  String time;
  String date;
  String category;
  Priority priority;
  bool completed;

  factory Task.fromMap(Map<String, dynamic> data, [String? id]) {
    return Task(
      data['title'] as String? ?? '',
      data['description'] as String? ?? '',
      data['time'] as String? ?? '',
      data['category'] as String? ?? '',
      _priorityFromValue(data['priority']),
      id: id ?? (data['id'] as String? ?? ''),
      date: data['date'] as String? ?? '',
      completed: data['completed'] == true,
    );
  }

  factory Task.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    return Task.fromMap(data, doc.id);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'category': category,
      'priority': priority.name,
      'completed': completed,
    };
  }

  static Priority _priorityFromValue(dynamic value) {
    if (value is Priority) {
      return value;
    }

    final rawValue = value?.toString().split('.').last;
    return Priority.values.firstWhere(
      (priority) => priority.name == rawValue,
      orElse: () => Priority.medium,
    );
  }
}
