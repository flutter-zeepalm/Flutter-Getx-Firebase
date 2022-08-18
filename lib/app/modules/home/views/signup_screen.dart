import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_getx/app/Models/user_model.dart';
import 'package:hive_getx/app/data/constants.dart';
import 'package:hive_getx/app/data/typography.dart';
import 'package:hive_getx/app/modules/home/controllers/auth_controller.dart';
import 'package:hive_getx/app/modules/home/views/login.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);
  AuthController authCont = Get.find<AuthController>();

  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Sign Up", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 80.h,
              ),
              Text("Sign UP",
                style: CustomTextStyle.kmediumTextStyle.copyWith(fontWeight: CustomFontWeight.kExtraBoldFontWeight,color: CustomColor.kpendingyellow ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Text("Email",
                style: CustomTextStyle.kmediumTextStyle.copyWith(fontWeight: CustomFontWeight.kBoldFontWeight,color: CustomColor.kblack ),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                controller: _email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!value.isEmail) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Enter Email",
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text("Password",
                style: CustomTextStyle.kmediumTextStyle.copyWith(fontWeight: CustomFontWeight.kBoldFontWeight,color: CustomColor.kblack ),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                  controller: _pass,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter Password",
                  )),
              SizedBox(height: 30.h),
              SizedBox(
                  height: 50.h,
                  width: 300.w,
                  child: ElevatedButton(onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      
                      authCont.signup( email: _email.text.trim(), password: _pass.text.trim(),);
                    }
                  },
                    child: Text("Sign Up",
                      style: CustomTextStyle.kmediumTextStyle.copyWith(fontWeight: CustomFontWeight.kBoldFontWeight,color: CustomColor.kwhite ),
                    ),


                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Have Account ? "),
                  SizedBox(
                      width: 10.h
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => LoginPage());
                    },
                    child: Text("Sign In? "),),
                ],
              )

              // ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       primary: Colors.black,
              //       fixedSize: Size(80.w, 30.h),
              //     ),
              //     onPressed: () {
              //       if (_formKey.currentState!.validate()) {
              //         signUpWithEmailPassword(
              //             _email.text.trim(), _pass.text.trim());
              //       }
              //     },
              //     child: const Text("Sign Up"))
            ]),
          ),
        ),
      ),
    );
  }

}
