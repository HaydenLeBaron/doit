import 'package:cloud_firestore/cloud_firestore.dart';

class Globals {
  static FirebaseFirestore firestore;

  static void initGlobals() {
    Globals.firestore = FirebaseFirestore.instance;
  }
}
