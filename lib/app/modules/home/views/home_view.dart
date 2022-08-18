import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_getx/app/Models/todo_model.dart';
import 'package:hive_getx/app/data/constants.dart';
import 'package:hive_getx/app/data/typography.dart';
import 'package:hive_getx/app/modules/home/controllers/todo_controller.dart';
import 'package:hive_getx/app/modules/home/views/add_task.dart';
import 'package:hive_getx/app/modules/home/views/timeline.dart';
import 'package:hive_getx/app/modules/home/views/update_screen.dart';

import '../Widgets/custom_app_bar.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          action: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    Get.to(()=> TimelineScreen());
                  },
                  child: Icon(Icons.feed_rounded)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                  }, child: Icon(Icons.exit_to_app_outlined)),
            )
          ],
          title: 'To do List',
          leading: SizedBox(),
        ),
      ),
      body: GetBuilder<TodoController>(
         init: TodoController(),
        builder: (cd) {
          return FutureBuilder<List<Todo>>(
              future: cd.getUsersTask(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<Todo>? todoList = snapshot.data;
                if (todoList!.isEmpty) {
                  return const Center(
                    child: Text("No Data found"),
                  );
                }
                return ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      Todo todo = todoList[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Dismissible(
                          background: Container(
                            color: Colors.red,
                          ),
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            cd.deleteTask(todo);
                           
                          },
                          child: ListTile(
                            onTap: () {
                              Get.to(() => UpdateScreen(
                                    uptodo: todo,
                                  ));
                            },
                            title: Text(
                              todo.title,
                              //controller.getdata(index)!.title,
                              style: CustomTextStyle.kmediumTextStyle.copyWith(
                                  fontWeight:
                                      CustomFontWeight.kExtraBoldFontWeight,
                                  color: CustomColor.kpendingyellow),
                            ),
                            subtitle: Text(
                              todo.description,
                              style: CustomTextStyle.ksearchTextStyle.copyWith(
                                  fontWeight: CustomFontWeight.kBoldFontWeight,
                                  color: CustomColor.kprimarygreen),
                            ),
                            // trailing: Checkbox(
                            //     // value: controller.getdata(index)!.isCheck,
                            //     // onChanged: (bool? value) {
                            //     //   controller.getdata(index)!.isCheck = value!;
                            //     //   controller.update();
                            //     }),
                          ),
                        ),
                      );
                    });
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColor.kprimarygreen,
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(() => AddTodoScreen());
        },
      ),
    );
  }
}
