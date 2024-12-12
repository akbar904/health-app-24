import 'package:flutter/material.dart';
import 'package:my_app/utils/validators.dart';

class AddTodoForm extends StatefulWidget {
  final Function(String title, String description) onSubmit;
  final String? initialTitle;
  final String? initialDescription;
  final bool isEditing;

  const AddTodoForm({
    Key? key,
    required this.onSubmit,
    this.initialTitle,
    this.initialDescription,
    this.isEditing = false,
  }) : super(key: key);

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _descriptionController =
        TextEditingController(text: widget.initialDescription);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(
        _titleController.text,
        _descriptionController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
            validator: Validators.validateTodoTitle,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            validator: Validators.validateTodoDescription,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _handleSubmit,
            child: Text(widget.isEditing ? 'Update Todo' : 'Add Todo'),
          ),
        ],
      ),
    );
  }
}
