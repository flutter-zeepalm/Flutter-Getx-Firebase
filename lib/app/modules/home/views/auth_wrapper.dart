import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_getx/app/modules/home/controllers/auth_controller.dart';
import 'package:hive_getx/app/modules/home/controllers/user_controller.dart';
import 'package:hive_getx/app/modules/home/views/home_view.dart';


import 'login.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
        init: AuthController(),
        builder: (ac) {
          if (ac.user == null) {
            return LoginPage();
          } else {
            return GetBuilder<UserController>(
                init: UserController(),
                builder: (uc) {
                  return MyHomePage();
                });
          }
        });
  }
}


