import 'package:flutter/material.dart';

class TodoInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;

  const TodoInput({
    required this.controller,
    required this.onSubmit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Add a new todo',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => onSubmit(),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: onSubmit,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
