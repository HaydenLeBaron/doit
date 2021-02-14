import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:doit/services/tasks_service.dart';
import 'package:doit/modules/task_list/fab_create_task.dart';
import 'package:doit/modules/task_list/task_tile.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: convert into MultiProvider pattern
    return StreamProvider<QuerySnapshot>(
      create: getTasksQuerySnapshotStream,
      child: Provider<GlobalKey<FormState>>(
        create: (context) => GlobalKey<FormState>(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("To Do"),
          ),
          body: TaskListBuilder(),
          floatingActionButton: FABCreateTask(),
        ),
      ),
    );
  }
}

class TaskListBuilder extends StatelessWidget {
  const TaskListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: Provider.of<QuerySnapshot>(context)
            .docs
            .length, // FIXME: this is breifly null and causes an error screen briefly (I think)
        itemBuilder: (context, idx) {
          var tasksDoc = Provider.of<QuerySnapshot>(context).docs[
              idx]; // FIXME: this is breifly null and causes an error screen briefly (I think)
          return Provider<int>(
            create: (context) => idx,
            child: TaskTile(
              description: tasksDoc['description'],
              isChecked: tasksDoc['isChecked'],
            ),
          );
        },
      ),
    );
  }
}
