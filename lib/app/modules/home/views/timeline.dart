import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_getx/app/Models/todo_model.dart';
import 'package:hive_getx/app/data/constants.dart';
import 'package:hive_getx/app/data/typography.dart';
import 'package:hive_getx/app/modules/home/controllers/todo_controller.dart';

import '../Widgets/custom_app_bar.dart';

class TimelineScreen extends StatelessWidget {
  TimelineScreen({Key? key}) : super(key: key);

  final TodoController _todoController = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          action: [],
          title: 'Timeline',
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back)),
        ),
      ),
      body: StreamBuilder<List<Todo>?>(
          stream: _todoController.getTask(),
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
            return SizedBox(
              height: 600.h,
              child: ListView.separated(
                itemCount: todoList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var todo = todoList[index];
                  return SizedBox(
                    height: 100.h,
                    width: double.infinity,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            todo.title,
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
                        ),
                        Row(
                          children: [
                            SizedBox(width: 15.w, height: 0),
                            Text(
                               "${todo.likes.length} likes",
                              style: CustomTextStyle.ksearchTextStyle
                                  .copyWith(
                                      fontWeight:
                                          CustomFontWeight.kBoldFontWeight,
                                      color: CustomColor.kprimarygreen),
                            ),
                            SizedBox(width: 10.w, height: 0),
                            InkWell(
                                onTap: () async {
                                  await _todoController.addLike(todo);
                                },
                                child: Icon(
                                  Icons.thumb_up_sharp,
                                  color: CustomColor.kred,
                                  size: 18.sp,
                                )),
                            SizedBox(width: 15.w, height: 0),
                            Text(
                               "${todo.dislikes.length} dislikes",
                              style: CustomTextStyle.ksearchTextStyle
                                  .copyWith(
                                      fontWeight:
                                          CustomFontWeight.kBoldFontWeight,
                                      color: CustomColor.kprimarygreen),
                            ),
                            SizedBox(width: 10.w, height: 0),
                            InkWell(
                                onTap: () async {
                                  await _todoController.addDisLike(todo);
                                },
                                child: Icon(
                                  Icons.thumb_down_sharp,
                                  color: CustomColor.kred,
                                  size: 18.sp,
                                )),
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, int index) {
                  return SizedBox(
                    height: 10.h,
                  );
                },
              ),
            );
          }),
    );
  }
}
