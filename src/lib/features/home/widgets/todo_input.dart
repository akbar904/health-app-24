import 'package:flutter/material.dart';

class TodoInput extends StatefulWidget {
  final Function(String) onSubmit;

  const TodoInput({
    required this.onSubmit,
    super.key,
  });

  @override
  State<TodoInput> createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  final _controller = TextEditingController();

  void _handleSubmit() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onSubmit(_controller.text);
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Add a new todo...',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _handleSubmit(),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: _handleSubmit,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
