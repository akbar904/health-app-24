import 'package:flutter/material.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:my_app/ui/widgets/empty_todo_state.dart';
import 'package:my_app/ui/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<TodoModel> todos;
  final Function(String) onToggleTodo;
  final Function(String) onEditTodo;
  final Function(String) onDeleteTodo;

  const TodoList({
    required this.todos,
    required this.onToggleTodo,
    required this.onEditTodo,
    required this.onDeleteTodo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const EmptyTodoState();
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onToggle: () => onToggleTodo(todo.id),
          onEdit: () => onEditTodo(todo.id),
          onDelete: () => onDeleteTodo(todo.id),
        );
      },
    );
  }
}
