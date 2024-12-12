import 'package:my_app/ui/bottom_sheets/add_todo/add_todo_sheet.dart';
import 'package:my_app/ui/dialogs/confirm_delete/confirm_delete_dialog.dart';
import 'package:my_app/ui/dialogs/todo_detail/todo_detail_dialog.dart';
import 'package:my_app/features/home/home_view.dart';
import 'package:my_app/features/startup/startup_view.dart';
import 'package:my_app/services/todo_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: TodoService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: AddTodoSheet),
  ],
  dialogs: [
    StackedDialog(classType: TodoDetailDialog),
    StackedDialog(classType: ConfirmDeleteDialog),
  ],
)
class App {}
