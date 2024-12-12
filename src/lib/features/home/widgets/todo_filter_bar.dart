import 'package:flutter/material.dart';

class TodoFilterBar extends StatelessWidget {
  final bool showCompleted;
  final ValueChanged<bool> onFilterChanged;

  const TodoFilterBar({
    super.key,
    required this.showCompleted,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(
            showCompleted ? 'Completed Tasks' : 'Active Tasks',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Switch(
            value: showCompleted,
            onChanged: onFilterChanged,
          ),
        ],
      ),
    );
  }
}
