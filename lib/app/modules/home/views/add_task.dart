import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_getx/app/Models/todo_model.dart';
import 'package:hive_getx/app/Services/database_services.dart';
import 'package:hive_getx/app/data/constants.dart';
import 'package:hive_getx/app/modules/home/Widgets/custom_app_bar.dart';
import 'package:hive_getx/app/modules/home/controllers/home_controller.dart';
import 'package:hive_getx/app/modules/home/controllers/todo_controller.dart';

class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({Key? key}) : super(key: key);
  final TodoController _todoController = Get.find<TodoController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String title;
  late String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          action: [],
          title: 'Add To Do,s',
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: CustomColor.kblack,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(hintText: 'Title'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    title = value;
                  },
                ),
                TextFormField(
                  maxLines: 4,
                  decoration: const InputDecoration(hintText: 'Description'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    description = value;
                  },
                ),
                SizedBox(height: 30.h),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Todo addtodo = Todo(
                            id: '',
                            title: title,
                            description: description,
                            isCheck: false, ownerid: '', likes: [], dislikes: [],
                          );
                          await _todoController.addTask(context, addtodo);
                          Get.back();
                        }
                      },
                      child: const Text(
                        'Add Todo',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
