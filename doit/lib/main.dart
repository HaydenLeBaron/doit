import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Do It',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: Colors.blue,
          accentColor: Colors.white,
        ),
        home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("To Do"),
          backgroundColor: Theme.of(context).primaryColor),
      body: TodoList(taskItems: [
        TaskItem(titleText: "Buy milk", isChecked: true),
        TaskItem(titleText: "Do math homework", isChecked: false),
        TaskItem(titleText: "Take out trash", isChecked: true),
        TaskItem(
            titleText:
                "asdf asd f asd f asd fa sd fas df asd f ads f asd f asdf  asd f",
            isChecked: true),
      ]),
    );
  }
}

class TodoList extends StatefulWidget {
  TodoList({Key key, @required this.taskItems}) : super(key: key);

  List<TaskItem> taskItems;

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.taskItems.length,
        itemBuilder: (BuildContext ctxt, int idx) {
          final taskItem = widget.taskItems[idx];
          return Dismissible(
            background: Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
                color: Colors.red),
            key: Key(taskItem.id.toString()),
            onDismissed: (direction) {
              setState(() {
                widget.taskItems.removeAt(idx);
              });

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Task deleted"),
                duration: Duration(milliseconds: 300),
              ));
            },
            child: taskItem,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Theme.of(context).accentColor,
        ),
        onPressed: () {
          setState(() {
            widget.taskItems.add(TaskItem(
              isChecked: false,
              titleText: "New Item!",
            ));
            print("FAB pressed");
            print(widget.taskItems);
          });
        }, // TODO: implement onpressed function
      ),
    );
  }
}

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
        title: Text(widget.titleText),
        onLongPress: () {}, // TODO: Implement move item on long-press (3)
      ),
    );
  }
}
