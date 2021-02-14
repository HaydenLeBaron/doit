import 'package:flutter/material.dart';
import 'helpers.dart';

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
