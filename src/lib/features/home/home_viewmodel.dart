import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:my_app/features/home/home_repository.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _repository = HomeRepository();

  List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;

  void initialize() {
    _loadTodos();
  }

  void _loadTodos() {
    setBusy(true);
    _todos = _repository.getTodos();
    setBusy(false);
  }

  void navigateToTodo() {
    _navigationService.navigateToTodoView();
  }

  Future<void> deleteTodo(String id) async {
    final response = await _dialogService.showDialog(
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
      buttonTitle: 'Delete',
      cancelTitle: 'Cancel',
    );

    if (response?.confirmed ?? false) {
      _repository.deleteTodo(id);
      _loadTodos();
      notifyListeners();
    }
  }

  void toggleTodoStatus(String id) {
    _repository.toggleTodoStatus(id);
    _loadTodos();
    notifyListeners();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Todo App',
      description: 'A simple todo app built with Stacked architecture',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: 'Todo App',
      description: 'Manage your tasks efficiently',
    );
  }
}
