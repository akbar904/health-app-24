import 'package:flutter/material.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:my_app/ui/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<TodoModel> todos;
  final Function(String) onToggle;
  final Function(TodoModel) onEdit;
  final Function(String) onDelete;

  const TodoList({
    Key? key,
    required this.todos,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onToggle: onToggle,
          onEdit: onEdit,
          onDelete: onDelete,
        );
      },
    );
  }
}
