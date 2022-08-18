import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class DatabaseServices {
  CollectionReference todoCollection =
    FirebaseFirestore.instance.collection('TodoList');
    CollectionReference userCollection =
    FirebaseFirestore.instance.collection('Users');


}
