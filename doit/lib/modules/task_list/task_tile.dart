import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:doit/services/tasks_service.dart';
import 'package:doit/modules/task_list/helpers.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key key, this.description, this.isChecked}) : super(key: key);

  final String description;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      // Can swipe right to dismiss TaskTile
      key: Key(getCurrDoc(context).reference.hashCode.toString()),
      child: ListTile(title: Text(this.description), leading: TaskCheckbox()),
      onDismissed: (DismissDirection direction) {
        DocumentSnapshot docSnap =
            getCurrDoc(context, qsnaplisten: false, idxlisten: false);
        // If Swipe L -> R
        if (direction == DismissDirection.startToEnd) {
          // Archive current task
          archiveTask(context, docSnap);
          // Show task archived snackbar
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Task archived"),
            duration: Duration(milliseconds: 400),
          ));
        }
        // If Swipe L <- R
        else {
          // Delete current task
          deleteDocument(context, docSnap);
          // Show task deleted snackbar
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Task deleted"),
            duration: Duration(milliseconds: 400),
          ));
        }
      },
      background: Row(
        children: [
          // Archive icon / color on left side
          Flexible(
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.archive,
                color: Colors.white,
              ),
              color: Colors.yellow,
            ),
          ),
          // Delete icon / color on right side
          Flexible(
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class TaskCheckbox extends StatelessWidget {
  const TaskCheckbox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var gestureDetector = GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(
          getCurrDoc(context, idxlisten: false)['isChecked']
              ? Icons.check_box
              : Icons.check_box_outline_blank,
          color: importanceToColor(
              getCurrDoc(context, idxlisten: false)['importance']),
          size: 26,
        ),
      ),
      onTap: () => toggleIsChecked(context,
          getCurrDoc(context, idxlisten: false, qsnaplisten: false).reference),
    );
    return Container(
      child: gestureDetector,
    );
  }
}
