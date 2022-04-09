import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yearbook_maker/controllers/user_controller.dart';

class UserHomepageController extends GetxController {
  var loading = false.obs;
  final UserController userController = Get.find();

  void logout() {
    GetStorage().remove('user');
    Get.offAllNamed('/login_screen');
  }
}
