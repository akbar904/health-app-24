import 'package:my_app/models/todo_model.dart';

class TodoService {
  final List<TodoModel> _todos = [];

  List<TodoModel> getTodos() {
    return List.unmodifiable(_todos);
  }

  void addTodo(TodoModel todo) {
    _todos.add(todo);
  }

  void updateTodo(TodoModel todo) {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
  }

  void toggleTodoStatus(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final todo = _todos[index];
      _todos[index] = todo.copyWith(
        isCompleted: !todo.isCompleted,
        completedAt: !todo.isCompleted ? DateTime.now() : null,
      );
    }
  }

  List<TodoModel> filterTodos({
    bool? isCompleted,
    String? searchQuery,
  }) {
    return _todos.where((todo) {
      if (isCompleted != null && todo.isCompleted != isCompleted) {
        return false;
      }
      if (searchQuery != null && searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        return todo.title.toLowerCase().contains(query) ||
            todo.description.toLowerCase().contains(query);
      }
      return true;
    }).toList();
  }
}
