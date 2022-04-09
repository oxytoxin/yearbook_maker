import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yearbook_maker/controllers/user_controller.dart';
import 'package:yearbook_maker/models/user.dart';
import 'package:yearbook_maker/shared/loader.dart';

class LoginScreenController extends GetxController {
  var loading = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Loader _loader = Get.find();
  final UserController userController = Get.find();
  GetStorage box = GetStorage();

  void login(Map values) async {
    _loader.load();
    var users = await firestore.collection('users').where('email', isEqualTo: values['email']).get();
    if (users.docs.isEmpty || users.docs[0]['password'] != values['password']) {
      Get.snackbar('User not found', 'No user registered with these credentials');
      _loader.unload();
      return;
    }
    var user = users.docs[0].data();
    user['id'] = users.docs[0].id;
    box.write('user', user);
    Stream<DocumentSnapshot> stream = firestore.collection('users').doc(user['id']).snapshots();
    userController.user.bindStream(stream.map((event) => User.fromDocumentSnapshot(event)));
    await FirebaseMessaging.instance.subscribeToTopic(user['id']);
    if (user['role'] == 'admin') {
      Get.offAllNamed('/admin/homepage');
    } else {
      Get.offAllNamed('/user/homepage');
    }
  }
}
