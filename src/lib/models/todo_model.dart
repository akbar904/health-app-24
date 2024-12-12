import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  final String id;
  final String title;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? completedAt;

  const TodoModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.createdAt,
    this.completedAt,
  });

  TodoModel copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as String,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }

  @override
  List<Object?> get props => [id, title, isCompleted, createdAt, completedAt];
}
