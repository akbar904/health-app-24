import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:intl/intl.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TodoItem({
    required this.todo,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(8),
            Text(todo.description),
            const Gap(8),
            Text(
              'Created: ${DateFormat.yMMMd().format(todo.createdAt)}',
              style: const TextStyle(fontSize: 12),
            ),
            if (todo.completedAt != null)
              Text(
                'Completed: ${DateFormat.yMMMd().format(todo.completedAt!)}',
                style: const TextStyle(fontSize: 12),
              ),
          ],
        ),
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => onToggle(),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
