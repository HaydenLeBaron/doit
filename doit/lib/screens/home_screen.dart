import 'package:flutter/material.dart';
import 'package:doit/shared/todo_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 90, 16, 48),
          child: Column(
            children: [
              FlatButton(
                onPressed: () {},
                child: Text("Drawer Item 1"),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: () {},
                child: Text("Drawer Item 2"),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
          title: Text("To Do"),
          backgroundColor: Theme.of(context).primaryColor),
      body: TodoList(taskItems: []),
    );
  }
}
