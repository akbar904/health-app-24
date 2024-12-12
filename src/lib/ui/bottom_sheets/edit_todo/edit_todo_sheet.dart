import 'package:flutter/material.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:stacked_services/stacked_services.dart';

class EditTodoSheet extends StatefulWidget {
  final Function(SheetResponse) completer;
  final SheetRequest request;

  const EditTodoSheet({
    required this.completer,
    required this.request,
    super.key,
  });

  @override
  State<EditTodoSheet> createState() => _EditTodoSheetState();
}

class _EditTodoSheetState extends State<EditTodoSheet> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    final TodoModel todo = widget.request.data;
    _titleController = TextEditingController(text: todo.title);
    _descriptionController = TextEditingController(text: todo.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Edit Todo',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () =>
                    widget.completer(SheetResponse(confirmed: false)),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final TodoModel todo = widget.request.data as TodoModel;
                  final updatedTodo = todo.copyWith(
                    title: _titleController.text,
                    description: _descriptionController.text,
                  );
                  widget.completer(
                    SheetResponse(
                      confirmed: true,
                      data: updatedTodo,
                    ),
                  );
                },
                child: const Text('Save'),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
