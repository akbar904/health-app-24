import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;

  const Todo({
    required this.id,
    required this.description,
    this.isCompleted = false,
    required this.createdAt,
  });

  Todo copyWith({
    String? id,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return Todo(
      id: id ?? this.id,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, description, isCompleted, createdAt];
}
