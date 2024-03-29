import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:doit/modules/task_list/task_list_screen.dart';
import 'package:doit/shared/loading_screen.dart';
import 'package:doit/shared/something_went_wrong_screen.dart';

void main() {
  //TestWidgetsFlutterBinding.ensureInitialized()
  runApp(DoitApp());
}

class DoitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Do It',
      theme: ThemeData(
        primaryColor: Colors.grey,
        accentColor: Colors.white,
      ),
      home: FutureBuilder(
        // Initialize FlutterFire before anything else
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return SomethingWentWrongScreen();
          }
          // Once complete, start to app
          else if (snapshot.connectionState == ConnectionState.done) {
            return TaskListScreen();
          }
          // Otherwise, show something while waiting for initialization to complete
          else {
            return LoadingScreen();
          }
        },
      ),
    );
  }
}
