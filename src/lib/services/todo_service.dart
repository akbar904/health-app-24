import 'package:logger/logger.dart';
import 'package:my_app/models/todo_model.dart';

class TodoService {
  final _logger = Logger();
  final List<TodoModel> _todos = [];

  List<TodoModel> get todos => List.unmodifiable(_todos);

  void addTodo(TodoModel todo) {
    _todos.add(todo);
    _logger.i('Added todo: ${todo.title}');
  }

  void updateTodo(TodoModel todo) {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
      _logger.i('Updated todo: ${todo.title}');
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    _logger.i('Deleted todo with id: $id');
  }

  void toggleTodoCompletion(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final todo = _todos[index];
      _todos[index] = todo.copyWith(
        isCompleted: !todo.isCompleted,
        completedAt: !todo.isCompleted ? DateTime.now() : null,
      );
      _logger.i('Toggled todo completion: ${todo.title}');
    }
  }

  List<TodoModel> getTodosByCompletion(bool isCompleted) {
    return _todos.where((todo) => todo.isCompleted == isCompleted).toList();
  }
}
