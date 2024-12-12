import 'package:my_app/models/todo.dart';

class TodoService {
  final List<Todo> _todos = [];

  List<Todo> getTodos({TodoStatus? filterStatus}) {
    if (filterStatus == null) {
      return List.from(_todos);
    }
    return _todos.where((todo) => todo.status == filterStatus).toList();
  }

  void addTodo(String title, String description) {
    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    _todos.add(todo);
  }

  void toggleTodoStatus(String todoId) {
    final todoIndex = _todos.indexWhere((todo) => todo.id == todoId);
    if (todoIndex != -1) {
      final todo = _todos[todoIndex];
      final newStatus = todo.status == TodoStatus.complete
          ? TodoStatus.incomplete
          : TodoStatus.complete;
      _todos[todoIndex] = todo.copyWith(
        status: newStatus,
        completedAt: newStatus == TodoStatus.complete ? DateTime.now() : null,
      );
    }
  }

  void deleteTodo(String todoId) {
    _todos.removeWhere((todo) => todo.id == todoId);
  }

  void updateTodo(String todoId, String title, String description) {
    final todoIndex = _todos.indexWhere((todo) => todo.id == todoId);
    if (todoIndex != -1) {
      _todos[todoIndex] = _todos[todoIndex].copyWith(
        title: title,
        description: description,
      );
    }
  }
}
