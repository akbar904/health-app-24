import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/models/todo.dart';
import 'package:my_app/app/services/todo_service.dart';
import 'package:my_app/enums/bottom_sheet_type.dart';
import 'package:my_app/enums/dialog_type.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  bool? _filterStatus;
  List<Todo> get todos =>
      _todoService.getFilteredTodos(isCompleted: _filterStatus);

  void filterTodos(bool? status) {
    _filterStatus = status;
    rebuildUi();
  }

  Future<void> addTodo() async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: 'Add Todo',
      description: 'Add a new todo item',
    );

    if (response?.confirmed == true && response?.data != null) {
      final todo = response!.data as Todo;
      _todoService.addTodo(todo);
      rebuildUi();
    }
  }

  Future<void> editTodo(Todo todo) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.custom,
      title: 'Edit Todo',
      description: 'Edit your todo item',
      data: todo,
    );

    if (response?.confirmed == true && response?.data != null) {
      final updatedTodo = response!.data as Todo;
      _todoService.updateTodo(updatedTodo);
      rebuildUi();
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.custom,
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
      data: todo,
    );

    if (response?.confirmed == true) {
      _todoService.deleteTodo(todo.id);
      rebuildUi();
    }
  }

  void toggleTodo(String id) {
    _todoService.toggleTodoCompletion(id);
    rebuildUi();
  }
}