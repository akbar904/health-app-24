import 'package:flutter/material.dart';

class AddTodoFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const AddTodoFAB({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}
