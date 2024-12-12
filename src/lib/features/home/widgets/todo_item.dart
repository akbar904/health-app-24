import 'package:flutter/material.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:intl/intl.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final Function(TodoModel) onToggle;
  final Function(TodoModel) onTap;

  const TodoItem({
    required this.todo,
    required this.onToggle,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        onTap: () => onTap(todo),
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => onToggle(todo),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            color: todo.isCompleted ? Colors.grey : Colors.black,
          ),
        ),
        subtitle: Text(
          'Created: ${DateFormat('MMM d, y').format(todo.createdAt)}',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: todo.isCompleted
            ? const Icon(Icons.check_circle, color: Colors.green)
            : null,
      ),
    );
  }
}
