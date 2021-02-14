import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

/// Auxillary function for getting the current document (using the QuerySnapshot and idx)
QueryDocumentSnapshot getCurrDoc(BuildContext context,
        {bool qsnaplisten = true, bool idxlisten = true}) =>
    Provider.of<QuerySnapshot>(context, listen: qsnaplisten)
        .docs[Provider.of<int>(context, listen: idxlisten)];

Color importanceToColor(int val) {
  switch (val) {
    case 1:
      return Colors.red;
      break;
    case 2:
      return Colors.orange;
      break;
    case 3:
      return Colors.blue;
      break;
    default: // 4
      return Colors.grey;
  }
}

class ImportancePickerController {
  int importance;

  ImportancePickerController(startingImportance) {
    importance = startingImportance;
  }
}
