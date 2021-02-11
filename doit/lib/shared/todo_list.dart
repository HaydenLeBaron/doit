import 'package:flutter/material.dart';
import 'package:doit/shared/task_item.dart';

class TodoList extends StatefulWidget {
  TodoList({Key key, @required this.taskItems}) : super(key: key);

  List<TaskItem> taskItems;

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();

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
        // TODO: refactor so that the FAB is part of the screen and not the todolist
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Theme.of(context).accentColor,
        ),
        onPressed: () {
          // Input task
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 1000,
                color: Theme.of(context).accentColor,
                child: Center(
                  // CREATE TASK FORM // ---------------------------------------
                  child: Scaffold(
                    body: Form(
                      key: _formKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: TextFormField(
                                controller: descriptionController,
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
                          ),
                          FlatButton(
                            //color: Theme.of(context).accentColor,
                            minWidth: 30,
                            onPressed: () {
                              // Validate will return true if the form is valid, or false if
                              // the form is invalid.
                              if (_formKey.currentState.validate()) {
                                // Process data.
                                setState(() {
                                  // Create new task item
                                  setState(() {
                                    widget.taskItems.add(
                                      TaskItem(
                                        isChecked: false,
                                        titleText: descriptionController.text,
                                      ),
                                    );
                                    descriptionController.text = "";
                                  });
                                });
                                Navigator.pop(context);
                              }
                            },
                            child: Icon(
                              Icons.arrow_right_alt,
                              size: 35,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
