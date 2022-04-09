import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yearbook_maker/controllers/user_controller.dart';
import 'package:yearbook_maker/models/user.dart';

class SplashScreenController extends GetxController {
  var loading = true.obs;
  GetStorage box = GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final UserController userController = Get.find();

  @override
  void onInit() async {
    await Future.delayed(1.seconds);
    if (box.read('user') != null) {
      Stream<DocumentSnapshot> stream = firestore.collection('users').doc(box.read('user')['id']).snapshots();
      userController.user.bindStream(stream.map((event) => User.fromDocumentSnapshot(event)));
      await FirebaseMessaging.instance.subscribeToTopic(box.read('user')['id']);
      if (box.read('user')['role'] == 'admin') {
        Get.offAllNamed('/admin/homepage');
      } else {
        Get.offAllNamed('/user/homepage');
      }
    } else {
      Get.offAllNamed('/login_screen');
    }
    super.onInit();
  }
}
