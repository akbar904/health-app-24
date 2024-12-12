import 'package:my_app/models/todo_model.dart';

class TodoService {
  final List<TodoModel> _todos = [];

  List<TodoModel> get todos => List.unmodifiable(_todos);

  void addTodo(TodoModel todo) {
    _todos.add(todo);
  }

  void updateTodo(TodoModel updatedTodo) {
    final index = _todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      _todos[index] = updatedTodo;
    }
  }

  void deleteTodo(String todoId) {
    _todos.removeWhere((todo) => todo.id == todoId);
  }

  void toggleTodoCompletion(String todoId) {
    final index = _todos.indexWhere((todo) => todo.id == todoId);
    if (index != -1) {
      final todo = _todos[index];
      _todos[index] = todo.copyWith(
        isCompleted: !todo.isCompleted,
        completedAt: !todo.isCompleted ? DateTime.now() : null,
      );
    }
  }

  TodoModel? getTodoById(String todoId) {
    return _todos.firstWhere((todo) => todo.id == todoId);
  }
}
