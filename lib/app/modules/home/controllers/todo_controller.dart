import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_getx/app/Models/todo_model.dart';
import 'package:hive_getx/app/Services/database_services.dart';
import 'package:ndialog/ndialog.dart';

class TodoController extends GetxController {
  DatabaseServices db = DatabaseServices();
  Future<void> addTask(BuildContext context, Todo todo) async {
    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text('Adding Task..'),
      message: const Text('Please waiting '),
    );
    progressDialog.show();
    try {
      var doc = db.todoCollection.doc();     
      todo.id = doc.id;
      todo.ownerid = FirebaseAuth.instance.currentUser!.uid;
      await doc.set(todo.toMap());
      progressDialog.dismiss();
      debugPrint('data added');
    } catch (e) {
      progressDialog.dismiss();
      Get.snackbar(
        "error",
        e.toString(),
        borderRadius: 15,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Stream<List<Todo>> getTask() {
    return db.todoCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Todo.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future updateTask(Todo todo) async {
    try {
      await db.todoCollection.doc(todo.id).update(todo.toMap());
    } on FirebaseException catch (e) {
      Get.snackbar(
        "error",
        e.toString(),
        borderRadius: 15,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future deleteTask(Todo todo) async {
    db.todoCollection.doc(todo.id).delete();
  }

  Future<List<Todo>> getUsersTask() async {
    try {
      List<Todo> usersTasks = [];
      var snapshot = await db.todoCollection.get();
      for (var docs in snapshot.docs) {
        Todo todo = Todo.fromMap(docs.data() as Map<String, dynamic>);
        if (todo.ownerid == FirebaseAuth.instance.currentUser!.uid) {
          usersTasks.add(todo);
        }
      }
      return usersTasks;
    } on FirebaseException catch (e) {
      Get.snackbar(
        "error",
        e.message!,
        borderRadius: 15,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }
  }

  Future<void> addLike(Todo todo) async {
    if (todo.likes.contains(todo.ownerid)) {
      todo.likes.remove(todo.ownerid);
    } else if (todo.dislikes.contains(todo.ownerid)) {
      todo.dislikes.remove(todo.ownerid);
      todo.likes.add(todo.ownerid);
    } else {
      todo.likes.add(todo.ownerid);
    }
    await updateTask(todo);
    print(todo.dislikes.length);
    update();
  }

  Future<void> addDisLike(Todo todo) async {
    if (todo.dislikes.contains(todo.ownerid)) {
      todo.dislikes.remove(todo.ownerid);
    } else if (todo.likes.contains(todo.ownerid)) {
      todo.likes.remove(todo.ownerid);
      todo.dislikes.add(todo.ownerid);
    } else {
      todo.dislikes.add(todo.ownerid);
    }
    await updateTask(todo);
    print(todo.dislikes.length);
    update();
  }
}
