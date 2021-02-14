import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

/// Auxillary function for getting the current document (using the QuerySnapshot and idx)
QueryDocumentSnapshot getCurrDoc(BuildContext context,
        {bool qsnaplisten = true, bool idxlisten = true}) =>
    Provider.of<QuerySnapshot>(context, listen: qsnaplisten)
        .docs[Provider.of<int>(context, listen: idxlisten)];
