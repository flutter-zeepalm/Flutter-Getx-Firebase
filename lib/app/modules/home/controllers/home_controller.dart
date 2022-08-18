import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_getx/app/Models/todo_model.dart';
import 'package:hive_getx/app/Services/database_services.dart';

class HomeController extends GetxController {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  var box = Hive.box<Todo>('todo');

  Future<void> onFormSubmit(Todo todo) async {

    await box.add(todo);
    Get.back();
  }

  Future<void> onFormSubmitUpdate(int index, Todo todo) async {
    await box.putAt(
      index,
      todo
    );
    Get.back();
  }
   Todo? getdata (int index){
    Todo? res =  box.getAt(index);
    return res;
   }
  

  // void check (bool? value) {                          
  //   res.isCheck = value!;
  //                              );

  // @override
  // void initState() {
  //   super.initState();
  //   titleController.text = widget.uptodo.title;
  //   descriptionController.text = widget.uptodo.description;


  // }
}
