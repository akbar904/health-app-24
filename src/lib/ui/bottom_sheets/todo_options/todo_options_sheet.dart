import 'package:flutter/material.dart';
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
          const Text(
            'Todo Options',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Todo'),
            onTap: () => completer(SheetResponse(data: 'edit')),
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete Todo'),
            onTap: () => completer(SheetResponse(data: 'delete')),
          ),
          ListTile(
            leading: const Icon(Icons.close),
            title: const Text('Cancel'),
            onTap: () => completer(SheetResponse(data: 'cancel')),
          ),
        ],
      ),
    );
  }
}
