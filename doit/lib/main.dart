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
      body: TodoList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Theme.of(context).accentColor,
        ),
        onPressed: () => {}, // TODO: implement onpressed function
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          TaskItem(titleText: "Buy milk", isChecked: true),
          TaskItem(titleText: "Do math homework", isChecked: false),
          TaskItem(titleText: "Take out trash", isChecked: true),
          TaskItem(titleText: "Take out trash", isChecked: true),
          TaskItem(titleText: "Take out trash", isChecked: true),
          TaskItem(titleText: "Take out trash", isChecked: true),
          TaskItem(titleText: "Take out trash", isChecked: true),
          TaskItem(titleText: "Take out trash", isChecked: true),
          TaskItem(titleText: "Take out trash", isChecked: true),
          TaskItem(titleText: "Take out trash", isChecked: true),
          TaskItem(titleText: "Take out trash", isChecked: true),
          TaskItem(titleText: "Take out trash", isChecked: true),
          TaskItem(titleText: "Take out trash", isChecked: true),
          TaskItem(titleText: "Take out trash", isChecked: true),
          TaskItem(titleText: "Take out trash", isChecked: true),
          TaskItem(titleText: "Take out trash", isChecked: true),
          TaskItem(titleText: "Take out trash", isChecked: true),
          TaskItem(titleText: "Take out trash", isChecked: true),
          TaskItem(titleText: "Take out trash", isChecked: true),
          TaskItem(titleText: "Take out trash", isChecked: true),
          TaskItem(titleText: "Take out trash", isChecked: true),
          TaskItem(titleText: "Take out trash", isChecked: true),
          TaskItem(titleText: "Take out trash", isChecked: true),
        ],
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({Key key, @required this.titleText, @required this.isChecked})
      : super(key: key);

  final String titleText;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: ListTile(
          leading: GestureDetector(
            child: Icon(this.isChecked
                ? Icons.check_box
                : Icons.check_box_outline_blank),
            onTap: () => {}, // TODO: Implement check/uncheck on tap (1)
          ),
          tileColor: Theme.of(context).accentColor,
          title: Text(this.titleText),
          onLongPress: () => {}, // TODO: Implement move item on long-press (3)
        ),
        onHorizontalDragEnd: (DragEndDetails details) =>
            {}, // TODO: Implement delete item on horizontal drag (2)
      ),
    );
  }
}
