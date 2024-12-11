import 'package:my_app/models/todo.dart';

class TodoRepository {
  final List<Todo> _todos = [];

  List<Todo> getAllTodos() {
    return List.unmodifiable(_todos);
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
  }

  void updateTodo(Todo todo) {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
  }

  Todo? getTodoById(String id) {
    return _todos.firstWhere((todo) => todo.id == id);
  }
}
