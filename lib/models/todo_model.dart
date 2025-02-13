// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TodoModel {
  final int id;
  final String title;
  final String description;
  final bool completed;
  final String dueDate;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.dueDate,
  });

  TodoModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? completed,
    String? dueDate,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
      'dueDate': dueDate,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      completed: map['completed'] as bool,
      dueDate: map['dueDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) => TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TodoModel(id: $id, title: $title, description: $description, completed: $completed, dueDate: $dueDate)';
  }

  @override
  bool operator ==(covariant TodoModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.completed == completed &&
      other.dueDate == dueDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      completed.hashCode ^
      dueDate.hashCode;
  }
}
