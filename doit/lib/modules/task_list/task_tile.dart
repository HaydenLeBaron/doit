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
        // Delete current task
        deleteDocument(
            context,
            direction,
            getCurrDoc(context, qsnaplisten: false, idxlisten: false)
                .reference);

        // Show task deleted snackbar
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Task deleted"),
          duration: Duration(milliseconds: 400),
        ));
      },
      background: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        color: Colors.red,
      ),
    );
  }
}

// TODO: try to convert to a regular Checkbox and see if it is more performant
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
