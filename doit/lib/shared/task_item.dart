import 'package:flutter/material.dart';

class TaskItem extends StatefulWidget {
  /* Used to new `id`s*/
  static int totalIds;

  /* Each TaskItem has a unique numeric `id`, to be used as a key. */
  int id;

  String titleText;
  bool isChecked;

  TaskItem({Key key, @required this.titleText, @required this.isChecked})
      : super(key: key) {
    if (TaskItem.totalIds == null) {
      TaskItem.totalIds = 0;
    }

    this.id = TaskItem.totalIds;
    TaskItem.totalIds += 1;
  }

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              widget.isChecked
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              size: 26,
            ),
          ),
          onTap: () {
            setState(() {
              widget.isChecked = !widget.isChecked;
            });

            // TODO: implement backend logic
          },
        ),
        tileColor: Theme.of(context).accentColor,
        title: EditableText(
          maxLines: 1,
          controller: TextEditingController(text: widget.titleText),
          cursorColor: Theme.of(context).primaryColor,
          backgroundCursorColor: Colors.orange,
          style: TextStyle(color: Colors.black),
          focusNode: FocusNode(),
        ),
        onLongPress: () {}, // TODO: Implement move item on long-press (3)
      ),
    );
  }
}
