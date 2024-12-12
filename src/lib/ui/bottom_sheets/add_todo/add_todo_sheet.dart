import 'package:flutter/material.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:stacked_services/stacked_services.dart';

class AddTodoSheet extends StatefulWidget {
  final Function(SheetResponse) completer;
  final SheetRequest request;

  const AddTodoSheet({
    required this.completer,
    required this.request,
    super.key,
  });

  @override
  State<AddTodoSheet> createState() => _AddTodoSheetState();
}

class _AddTodoSheetState extends State<AddTodoSheet> {
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
            'Add New Todo',
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
                  if (_titleController.text.isEmpty) {
                    return;
                  }
                  final newTodo = TodoModel(
                    id: DateTime.now().toString(),
                    title: _titleController.text,
                    description: _descriptionController.text,
                    createdAt: DateTime.now(),
                  );
                  widget.completer(
                    SheetResponse(
                      confirmed: true,
                      data: newTodo,
                    ),
                  );
                },
                child: const Text('Add'),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
