import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EmptyTodoState extends StatelessWidget {
  const EmptyTodoState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const Gap(16),
          Text(
            'No todos yet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const Gap(8),
          Text(
            'Tap the + button to add a new todo',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
