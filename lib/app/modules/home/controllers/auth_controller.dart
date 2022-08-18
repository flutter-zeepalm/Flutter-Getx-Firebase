import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_getx/app/Models/user_model.dart';
import 'package:hive_getx/app/Services/database_services.dart';



class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> _firebaseUser = Rx<User?>(null);
  User? get user => _firebaseUser.value;
  DatabaseServices db = DatabaseServices();


   @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    update();
    super.onInit();
  }





  Future<void> signup({required String email,required String password}) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: email, password: password)
          .then((value) async {
        UserModel myuser = UserModel(
            uid: value.user!.uid,
            email: value.user!.email!,
            name: '',
            pic:'',
            );
        await _createUserFirestore(myuser, value.user!);
        Get.back();
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar('User', 'Message', messageText: Text(e.toString()));
    }
    ;
  }

  Future<void> _createUserFirestore(UserModel user, User firebaseUser) async {
    await db.userCollection.doc(firebaseUser.uid).set(user.toMap());
    update();
  }

  Future login({required String email,required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password:password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('User', 'Message', messageText: Text(e.toString()));
    }
  }


}
