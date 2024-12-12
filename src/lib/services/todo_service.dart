import 'package:my_app/models/todo_model.dart';

class TodoService {
  final List<TodoModel> _todos = [];

  List<TodoModel> get todos => List.unmodifiable(_todos);

  void addTodo(TodoModel todo) {
    _todos.add(todo);
  }

  void toggleTodoComplete(String id) {
    final todoIndex = _todos.indexWhere((todo) => todo.id == id);
    if (todoIndex != -1) {
      final todo = _todos[todoIndex];
      _todos[todoIndex] = todo.copyWith(isCompleted: !todo.isCompleted);
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
  }

  void updateTodo(TodoModel updatedTodo) {
    final index = _todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      _todos[index] = updatedTodo;
    }
  }
}
