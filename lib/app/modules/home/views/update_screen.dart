import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_getx/app/Models/todo_model.dart';
import 'package:hive_getx/app/Models/user_model.dart';
import 'package:hive_getx/app/data/constants.dart';
import 'package:hive_getx/app/modules/home/controllers/home_controller.dart';
import 'package:hive_getx/app/modules/home/controllers/todo_controller.dart';

import '../Widgets/custom_app_bar.dart';

class UpdateScreen extends StatefulWidget {
  final Todo uptodo;

  UpdateScreen({
    Key? key,
    required this.uptodo,
  }) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final TodoController _todoController = Get.find<TodoController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.uptodo.title;
    descriptionController.text = widget.uptodo.description;
    super.initState();
  }

  late String title = widget.uptodo.title;

  late String description = widget.uptodo.description;

  late bool isCheckUpdate = widget.uptodo.isCheck;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          action: [],
          title: 'UpDate To do',
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
                  controller: titleController,
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
                  controller: descriptionController,
                  autofocus: false,
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
                          Todo updatetodo = Todo(
                              id: widget.uptodo.id,
                              title: title,
                              isCheck: widget.uptodo.isCheck,
                              description: description, ownerid: widget.uptodo.ownerid, likes: widget.uptodo.likes, dislikes: widget.uptodo.dislikes);
                          await _todoController.updateTask(updatetodo);
                          Get.back();
                        }
                      },
                      child: const Text('Update Todo',
                          style: TextStyle(color: Colors.white, fontSize: 20))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
