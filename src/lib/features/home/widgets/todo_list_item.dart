import 'package:flutter/material.dart';
import 'package:my_app/models/todo_model.dart';

class TodoListItem extends StatelessWidget {
  final TodoModel todo;
  final Function(bool?) onToggleComplete;
  final VoidCallback onDelete;

  const TodoListItem({
    required this.todo,
    required this.onToggleComplete,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: onToggleComplete,
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          todo.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
