import 'package:flutter/material.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoOptionsSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const TodoOptionsSheet({
    required this.request,
    required this.completer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final todo = request.data as TodoModel;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            todo.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: Icon(
              todo.isCompleted ? Icons.refresh : Icons.check_circle,
              color: Colors.green,
            ),
            title: Text(
              todo.isCompleted ? 'Mark as incomplete' : 'Mark as complete',
            ),
            onTap: () => completer(SheetResponse(data: 'toggle')),
          ),
          ListTile(
            leading: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            title: const Text('Delete todo'),
            onTap: () => completer(SheetResponse(data: 'delete')),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
