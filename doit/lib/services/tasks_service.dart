import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Return snapshot stream of `tasks` collection
Stream<QuerySnapshot> getTasksQuerySnapshotStream(BuildContext context) =>
    FirebaseFirestore.instance.collection("tasks").snapshots();

/// Delete document `docSnap` from the database.
void deleteDocument(BuildContext context, DocumentSnapshot docSnap) async {
  await FirebaseFirestore.instance.runTransaction((transaction) async {
    transaction.delete(docSnap.reference);
  });
}

/// Delete document `docSnap` from the `tasks` collection.
/// and create an identical task in the `archived_tasks` collection.
void archiveTask(BuildContext context, DocumentSnapshot docSnap) async {
  await FirebaseFirestore.instance.runTransaction((transaction) async {
    final newDocRef =
        FirebaseFirestore.instance.collection('archived_tasks').doc();
    transaction.set(newDocRef, {
      'description': docSnap['description'],
      'importance': docSnap['importance'],
      'isChecked': docSnap['isChecked'],
    });

    transaction.delete(docSnap.reference);
  });
}

/// Toggle the `isChecked` field of the document `docRef`.
void toggleIsChecked(BuildContext context, DocumentReference docRef) {
  // https://www.youtube.com/watch?v=DqJ_KjFzL9I
  FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentSnapshot freshSnap = await transaction.get(docRef);
    transaction.update(freshSnap.reference, {
      'isChecked': !freshSnap['isChecked'],
    });
  });
}

/// Add a new document to the db to the `tasks` collection, where the `description` field
/// is the string `taskDesc`, and the `isChecked` field is false.
void createTaskModel(String taskDesc, int importance) async {
  await FirebaseFirestore.instance.runTransaction((transaction) async {
    // Create a reference to a document that doesn't exist yet, it has a random id
    final newDocRef = FirebaseFirestore.instance.collection('tasks').doc();
    // Then write to the new document
    transaction.set(newDocRef, {
      'description': taskDesc,
      'isChecked': false,
      'importance': importance,
    });
  });
}
