import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/models/todo_model.dart';

class TodoFormDialog extends StatefulWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const TodoFormDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  State<TodoFormDialog> createState() => _TodoFormDialogState();
}

class _TodoFormDialogState extends State<TodoFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.request.title ?? 'Add Todo',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () =>
                        widget.completer(DialogResponse(confirmed: false)),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final todo = TodoModel(
                          id: DateTime.now().toString(),
                          title: _titleController.text,
                          description: _descriptionController.text,
                        );
                        widget.completer(DialogResponse(
                          confirmed: true,
                          data: todo,
                        ));
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
