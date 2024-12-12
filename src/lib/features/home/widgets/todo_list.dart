import 'package:flutter/material.dart';
import 'package:my_app/models/todo.dart';
import 'todo_list_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(String) onTodoTap;
  final Function(String) onTodoLongPress;

  const TodoList({
    required this.todos,
    required this.onTodoTap,
    required this.onTodoLongPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(
        child: Text(
          'No todos yet!\nTap + to add a new todo',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: todos.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoListItem(
          todo: todo,
          onTap: () => onTodoTap(todo.id),
          onLongPress: () => onTodoLongPress(todo.id),
        );
      },
    );
  }
}
