import 'package:equatable/equatable.dart';

enum TodoStatus { incomplete, complete }

class Todo extends Equatable {
  final String id;
  final String title;
  final String description;
  final TodoStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;

  const Todo({
    required this.id,
    required this.title,
    required this.description,
    this.status = TodoStatus.incomplete,
    required this.createdAt,
    this.completedAt,
  });

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    TodoStatus? status,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        createdAt,
        completedAt,
      ];
}
