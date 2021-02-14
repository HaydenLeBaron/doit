import 'package:doit/modules/task_list/create_task_form/task_desc_field.dart';
import 'package:flutter/material.dart';
import 'package:doit/modules/task_list/helpers.dart';
import 'package:doit/modules/task_list/create_task_form/importance_picker.dart';
import 'package:doit/modules/task_list/create_task_form/confirm_create_task_button.dart';

class CreateTaskForm extends StatefulWidget {
  CreateTaskForm({Key key, @required this.formKey}) : super(key: key);

  final formKey;

  @override
  _CreateTaskFormState createState() => _CreateTaskFormState();
}

class _CreateTaskFormState extends State<CreateTaskForm> {
  final _taskDescController = TextEditingController();
  final _imporancePickerController = ImportancePickerController(4);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    try {
      _taskDescController.dispose();
      super.dispose();
    } on FlutterError catch (e) {
      // FIXME: This error gets thrown randomly if I try to delete tasks too fast
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImportancePicker(
            controller: _imporancePickerController,
          ),
          TaskDescField(
            taskDescController: _taskDescController,
          ),
          ConfirmCreateTaskButton(
            taskDescController: _taskDescController,
            importancePickerController: _imporancePickerController,
            formKey: widget.formKey,
          )
        ],
      ),
    );
  }
}
