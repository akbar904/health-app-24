import 'package:my_app/features/todos/todo_model.dart';

class TodoService {
  final List<Todo> _todos = [];

  Future<List<Todo>> getTodos() async {
    return _todos;
  }

  Future<void> addTodo(String description) async {
    _todos.add(
      Todo(
        id: DateTime.now().toString(),
        description: description,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> toggleTodo(Todo todo) async {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo.copyWith(isCompleted: !todo.isCompleted);
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    _todos.removeWhere((t) => t.id == todo.id);
  }
}
