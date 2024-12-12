import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/todo.dart';
import 'package:my_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ReactiveViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();

  List<Todo> get todos => _todoService.todos;

  Future<void> showAddTodoDialog() async {
    final response = await _dialogService.showCustomDialog(
      variant: 'todo',
      title: 'Add Todo',
    );

    if (response?.confirmed == true &&
        response?.data != null &&
        response!.data['title'].toString().isNotEmpty) {
      final todo = Todo(
        id: DateTime.now().toString(),
        title: response.data['title'],
        description: response.data['description'] ?? '',
        createdAt: DateTime.now(),
      );
      _todoService.addTodo(todo);
      rebuildUi();
    }
  }

  void toggleTodoCompletion(String id) {
    _todoService.toggleTodoCompletion(id);
    rebuildUi();
  }

  void deleteTodo(String id) {
    _todoService.deleteTodo(id);
    rebuildUi();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_todoService];
}
