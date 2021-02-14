import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doit/modules/task_list/create_task_form/create_task_form.dart';

class FABCreateTask extends StatelessWidget {
  const FABCreateTask({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(Icons.add, color: Theme.of(context).accentColor),
      onPressed: () {
        final formKey =
            Provider.of<GlobalKey<FormState>>(context, listen: false);

        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 1000,
              color: Theme.of(context).accentColor,
              alignment: Alignment.topCenter,
              child: CreateTaskForm(
                formKey: formKey,
              ),
            );
          },
        );
      },
    );
  }
}
