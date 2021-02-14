import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

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

// TODO: move to services/
Stream<QuerySnapshot> getTasksQuerySnapshotStream(BuildContext context) =>
    FirebaseFirestore.instance.collection("tasks").snapshots();

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
          // Task Description Field ----------------------
          TaskDescField(
            taskDescController: _taskDescController,
          ),

          // Confirm button --------------------------------
          ConfirmCreateTaskButton(
            taskDescController: _taskDescController,
            formKey: widget.formKey,
          )
        ],
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

// TODO: move this function to services directory:
/// Add a new document to the db to the `tasks` collection, where the `description` field
/// is the string `taskDesc`, and the `isChecked` field is false.
void createTaskModel(String taskDesc) async {
  await FirebaseFirestore.instance.runTransaction((transaction) async {
    // Create a reference to a document that doesn't exist yet, it has a random id
    final newDocRef =
        await FirebaseFirestore.instance.collection('tasks').doc();
    // Then write to the new document
    transaction.set(newDocRef, {'description': taskDesc, 'isChecked': false});
  });
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

class TaskTile extends StatelessWidget {
  const TaskTile({Key key, this.description, this.isChecked}) : super(key: key);

  final String description;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      // Can swipe right to dismiss TaskTile
      key: Key(getCurrDoc(context).reference.hashCode.toString()),
      child: ListTile(title: Text(this.description), leading: Checkbox()),
      onDismissed: (DismissDirection direction) => deleteDocument(
          context,
          direction,
          getCurrDoc(context, qsnaplisten: false, idxlisten: false).reference),
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

// TODO: factor out into services/
void deleteDocument(BuildContext context, DismissDirection direction,
    DocumentReference docRef) async {
  await FirebaseFirestore.instance.runTransaction((transaction) async {
    await transaction.delete(docRef);
  });

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Task deleted"),
    duration: Duration(milliseconds: 300),
  ));
}

class Checkbox extends StatelessWidget {
  const Checkbox({
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

// TODO: move this to services/

/// Toggle the `isChecked` field of the document `docRef`.
void toggleIsChecked(BuildContext context, DocumentReference docRef) {
  // https://www.youtube.com/watch?v=DqJ_KjFzL9I
  FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentSnapshot freshSnap = await transaction.get(docRef);
    await transaction.update(freshSnap.reference, {
      'isChecked': !freshSnap['isChecked'],
    });
  });
}

/// Auxillary function for getting the current document (using the QuesrySnapshot and idx)
QueryDocumentSnapshot getCurrDoc(BuildContext context,
        {bool qsnaplisten = true, bool idxlisten = true}) =>
    Provider.of<QuerySnapshot>(context, listen: qsnaplisten)
        .docs[Provider.of<int>(context, listen: idxlisten)];
