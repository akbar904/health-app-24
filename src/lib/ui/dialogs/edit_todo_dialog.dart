import 'package:flutter/material.dart';
import 'package:my_app/app/models/todo.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EditTodoDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const EditTodoDialog({
    required this.request,
    required this.completer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditTodoDialogModel>.reactive(
      viewModelBuilder: () => EditTodoDialogModel(request.data as Todo),
      builder: (context, model, child) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit Todo',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: model.titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: model.descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () =>
                        completer(DialogResponse(confirmed: false)),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (model.isValid) {
                        completer(
                          DialogResponse(
                            confirmed: true,
                            data: model.getUpdatedTodo(),
                          ),
                        );
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditTodoDialogModel extends BaseViewModel {
  final Todo originalTodo;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  EditTodoDialogModel(this.originalTodo) {
    titleController.text = originalTodo.title;
    descriptionController.text = originalTodo.description;
  }

  bool get isValid =>
      titleController.text.isNotEmpty && descriptionController.text.isNotEmpty;

  Todo getUpdatedTodo() {
    return originalTodo.copyWith(
      title: titleController.text,
      description: descriptionController.text,
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
