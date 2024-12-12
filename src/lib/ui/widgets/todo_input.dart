import 'package:flutter/material.dart';

class TodoInput extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final VoidCallback onSubmit;
  final String submitButtonText;

  const TodoInput({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.onSubmit,
    this.submitButtonText = 'Add Todo',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: descriptionController,
          decoration: const InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onSubmit,
          child: Text(submitButtonText),
        ),
      ],
    );
  }
}
