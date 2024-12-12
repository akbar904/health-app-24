import 'package:flutter/material.dart';
import 'package:my_app/app/models/todo.dart';
import 'package:stacked_services/stacked_services.dart';

class DeleteTodoDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const DeleteTodoDialog({
    required this.request,
    required this.completer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final todo = request.data as Todo;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Delete Todo',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Text('Are you sure you want to delete "${todo.title}"?'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => completer(DialogResponse(confirmed: false)),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => completer(DialogResponse(confirmed: true)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
