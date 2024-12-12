import 'package:my_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:my_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:my_app/ui/dialogs/confirm_delete/confirm_delete_dialog.dart';
import 'package:my_app/ui/bottom_sheets/todo_options/todo_options_sheet.dart';
import 'package:my_app/features/home/home_view.dart';
import 'package:my_app/features/startup/startup_view.dart';
import 'package:my_app/services/storage_service.dart';
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
    LazySingleton(classType: StorageService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: TodoOptionsSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: ConfirmDeleteDialog),
  ],
)
class App {}
