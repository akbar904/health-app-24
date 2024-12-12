import 'package:flutter/material.dart';

class AddTodoButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddTodoButton({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}
