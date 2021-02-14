import 'package:flutter/material.dart';
import 'package:doit/services/tasks_service.dart';
import 'package:doit/modules/task_list/helpers.dart';

class ConfirmCreateTaskButton extends StatelessWidget {
  const ConfirmCreateTaskButton(
      {Key key,
      @required this.taskDescController,
      @required this.importancePickerController,
      @required this.formKey})
      : super(key: key);

  final TextEditingController taskDescController;
  final ImportancePickerController importancePickerController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      minWidth: 30,
      onPressed: () async {
        // If form is valid
        if (formKey.currentState.validate()) {
          createTaskModel(
            taskDescController.text,
            importancePickerController.importance,
          );
          Navigator.pop(context);
        }
      },
      child: Icon(
        Icons.arrow_right_alt,
        size: 35,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
