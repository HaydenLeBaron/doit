import 'package:flutter/material.dart';
import 'package:doit/services/tasks_service.dart';
import 'package:doit/modules/task_list/helpers.dart';

class CreateTaskForm extends StatefulWidget {
  CreateTaskForm({Key key, @required this.formKey}) : super(key: key);

  final formKey;

  @override
  _CreateTaskFormState createState() => _CreateTaskFormState();
}

class ImportancePickerController {
  int importance;

  ImportancePickerController(startingImportance) {
    importance = startingImportance;
  }
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

class ImportancePicker extends StatefulWidget {
  ImportancePicker({Key key, @required this.controller}) : super(key: key);

  final ImportancePickerController controller;

  @override
  _ImportancePickerState createState() => _ImportancePickerState();
}

class _ImportancePickerState extends State<ImportancePicker> {
  @override
  Widget build(BuildContext context) {
    int dropdownValue = widget.controller.importance;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: DropdownButton<int>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        onChanged: (int newValue) {
          setState(() {
            widget.controller.importance = newValue;
          });
        },
        items: <int>[1, 2, 3, 4].map<DropdownMenuItem<int>>((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Container(
                color: importanceToColor(value), child: Text(value.toString())),
          );
        }).toList(),
      ),
    );
  }
}

class TaskDescField extends StatelessWidget {
  const TaskDescField({Key key, @required this.taskDescController})
      : super(key: key);
  final TextEditingController taskDescController;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: TextFormField(
          controller: taskDescController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Task Description",
          ),
          validator: (value) {
            if (value.isEmpty) {
              return "Please enter some text";
            }
            return null;
          },
        ),
      ),
    );
  }
}

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
