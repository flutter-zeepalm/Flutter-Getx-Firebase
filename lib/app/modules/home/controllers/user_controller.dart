

import 'package:get/get.dart';
import 'package:hive_getx/app/Models/user_model.dart';
import 'package:hive_getx/app/Services/database_services.dart';
import 'package:hive_getx/app/modules/home/controllers/auth_controller.dart';

class UserController extends GetxController {
  DatabaseServices db = DatabaseServices();
  Rx<UserModel?> _userModel = UserModel(uid: "").obs;
  AuthController authController = Get.find<AuthController>();

  UserModel get user => _userModel.value!;

  Future<UserModel> getCurrentUser()async{
    return await db.userCollection.doc(authController.user!.uid).get().then((doc){
      return UserModel.fromMap(doc.data() as Map<String,dynamic>);
    });
  }

  @override
  Future<void> onReady() async{
   _userModel.value = await getCurrentUser();

    super.onReady();
  }
}
