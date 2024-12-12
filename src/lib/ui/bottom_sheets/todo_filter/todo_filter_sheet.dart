import 'package:flutter/material.dart';
import 'package:my_app/models/todo.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoFilterSheet extends StatelessWidget {
  final Function(SheetResponse)? completer;
  final SheetRequest request;

  const TodoFilterSheet({
    super.key,
    required this.completer,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
            'Filter Todos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('All'),
            onTap: () => completer?.call(SheetResponse(data: null)),
          ),
          ListTile(
            title: const Text('Incomplete'),
            onTap: () =>
                completer?.call(SheetResponse(data: TodoStatus.incomplete)),
          ),
          ListTile(
            title: const Text('Complete'),
            onTap: () =>
                completer?.call(SheetResponse(data: TodoStatus.complete)),
          ),
        ],
      ),
    );
  }
}
