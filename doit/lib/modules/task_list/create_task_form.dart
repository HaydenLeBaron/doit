import 'package:flutter/material.dart';
import 'package:doit/services/tasks_service.dart';

class CreateTaskForm extends StatefulWidget {
  CreateTaskForm({Key key, @required this.formKey}) : super(key: key);

  final formKey;

  @override
  _CreateTaskFormState createState() => _CreateTaskFormState();
}

class _CreateTaskFormState extends State<CreateTaskForm> {
  final _taskDescController = TextEditingController();

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
          ImportancePicker(),
          TaskDescField(
            taskDescController: _taskDescController,
          ),
          ConfirmCreateTaskButton(
            taskDescController: _taskDescController,
            formKey: widget.formKey,
          )
        ],
      ),
    );
  }
}

class ImportancePicker extends StatefulWidget {
  ImportancePicker({Key key}) : super(key: key);

  @override
  _ImportancePickerState createState() => _ImportancePickerState();
}

class _ImportancePickerState extends State<ImportancePicker> {
  int dropdownValue = 4;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: DropdownButton<int>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        onChanged: (int newValue) {
          setState(() {
            dropdownValue = newValue;
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

Color importanceToColor(int val) {
  switch (val) {
    case 1:
      return Colors.red;
      break;
    case 2:
      return Colors.yellow;
      break;
    case 3:
      return Colors.blue;
      break;
    default: // 4
      return Colors.grey;
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
      {Key key, @required this.taskDescController, @required this.formKey})
      : super(key: key);

  final TextEditingController taskDescController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      minWidth: 30,
      onPressed: () async {
        // If form is valid
        if (formKey.currentState.validate()) {
          createTaskModel(taskDescController.text);
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
