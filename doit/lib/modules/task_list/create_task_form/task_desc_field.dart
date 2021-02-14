import 'package:flutter/material.dart';

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
