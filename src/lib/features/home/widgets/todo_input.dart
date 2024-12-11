import 'package:flutter/material.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoInput extends StatelessWidget {
  const TodoInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton(
        onPressed: () {
          locator<BottomSheetService>().showBottomSheet(
            title: 'Add New Todo',
            description: 'Enter todo details',
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: const Text(
          'Add New Todo',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
