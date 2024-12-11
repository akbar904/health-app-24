import 'package:my_app/features/home/todo_repository.dart';
import 'package:my_app/models/todo.dart';

class TodoService {
  final TodoRepository _repository = TodoRepository();

  List<Todo> getAllTodos() {
    return _repository.getAllTodos();
  }

  void addTodo({required String title, required String description}) {
    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    _repository.addTodo(todo);
  }

  void toggleTodoComplete(String id) {
    final todo = _repository.getTodoById(id);
    if (todo != null) {
      final updatedTodo = todo.copyWith(
        isCompleted: !todo.isCompleted,
        completedAt: !todo.isCompleted ? DateTime.now() : null,
      );
      _repository.updateTodo(updatedTodo);
    }
  }

  void deleteTodo(String id) {
    _repository.deleteTodo(id);
  }

  void updateTodo({
    required String id,
    required String title,
    required String description,
  }) {
    final todo = _repository.getTodoById(id);
    if (todo != null) {
      final updatedTodo = todo.copyWith(
        title: title,
        description: description,
      );
      _repository.updateTodo(updatedTodo);
    }
  }

  Todo? getTodoById(String id) {
    return _repository.getTodoById(id);
  }
}
