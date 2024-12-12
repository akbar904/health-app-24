import 'package:flutter/material.dart';
import 'package:my_app/models/todo.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const TodoListItem({
    required this.todo,
    required this.onTap,
    required this.onLongPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        leading: Icon(
          todo.isCompleted ? Icons.check_circle : Icons.circle_outlined,
          color: todo.isCompleted ? Colors.green : Colors.grey,
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            color: todo.isCompleted ? Colors.grey : null,
          ),
        ),
        trailing: Icon(
          Icons.more_vert,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}
