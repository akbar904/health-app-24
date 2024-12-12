import 'package:flutter/material.dart';

class AddTodoForm extends StatefulWidget {
  final String? initialTitle;
  final String? initialDescription;
  final bool isEditing;
  final Function(String title, String description) onSubmit;

  const AddTodoForm({
    Key? key,
    this.initialTitle,
    this.initialDescription,
    this.isEditing = false,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _descriptionController = TextEditingController(text: widget.initialDescription);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            widget.onSubmit(
              _titleController.text,
              _descriptionController.text,
            );
          },
          child: Text(widget.isEditing ? 'Update' : 'Add'),
        ),
      ],
    );
  }
}