import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:my_app/services/todo_service.dart';

class TodoRepository {
  final _todoService = locator<TodoService>();

  List<TodoModel> getTodos() {
    return _todoService.getTodos();
  }

  void addTodo(TodoModel todo) {
    _todoService.addTodo(todo);
  }

  void updateTodo(TodoModel todo) {
    _todoService.updateTodo(todo);
  }

  void deleteTodo(String id) {
    _todoService.deleteTodo(id);
  }

  void toggleTodoStatus(String id) {
    _todoService.toggleTodoStatus(id);
  }

  List<TodoModel> filterTodos({
    bool? isCompleted,
    String? searchQuery,
  }) {
    return _todoService.filterTodos(
      isCompleted: isCompleted,
      searchQuery: searchQuery,
    );
  }
}
