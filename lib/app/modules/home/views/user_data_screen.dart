import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_getx/app/Models/user_model.dart';
import 'package:hive_getx/app/modules/home/controllers/user_controller.dart';

class UserData extends StatelessWidget {
  UserData({
    Key? key,
  }) : super(key: key);
  UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<UserModel?>(
            future: userController.getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              UserModel currentUser = snapshot.data!;
              return Text(currentUser.email!);
            }),
      ),
    );
  }
}
