import 'package:flutter/material.dart';

class TodoAddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const TodoAddButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}
