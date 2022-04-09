import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yearbook_maker/controllers/user_controller.dart';
import 'package:yearbook_maker/models/user.dart';
import 'package:yearbook_maker/shared/loader.dart';

class AdminEditUserController extends GetxController {
  var loading = true.obs;
  Rx<User> user = User(id: '', image: '', password: '', role: '', lastName: '', firstName: '', email: '').obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late DocumentSnapshot doc;
  GetStorage box = GetStorage();
  final Loader _loader = Get.find();
  final UserController userController = Get.find();
  @override
  void onInit() async {
    if (Get.parameters['id']! != 'new') {
      doc = await firestore.collection('users').doc(Get.parameters['id']!).get();
      user.value = User.fromDocumentSnapshot(doc);
    }
    super.onInit();
    loading.value = false;
  }

  void deleteUser() {
    _loader.load();
    firestore.collection('users').doc(doc.id).delete();
    _loader.unload();
    Get.back(closeOverlays: true);
    Get.snackbar('Success', 'User deleted!');
  }

  void save(Map<String, dynamic> values) async {
    _loader.load();

    var temp = await getTemporaryDirectory();
    var val = Map.of(values);
    if (values['image'] == null) {
      val['image'] = user.value.image;
    } else {
      XFile img = values['image'][0];
      File? file = await FlutterImageCompress.compressAndGetFile(img.path, temp.path + '/image.jpeg',
          format: CompressFormat.jpeg, quality: 20);
      await FirebaseStorage.instance.ref('uploads/${user.value.id}').putFile(file!);
      val['image'] = await FirebaseStorage.instance.ref('uploads/${user.value.id}').getDownloadURL();
    }
    if (user.value.id == '') {
      await firestore.collection('users').add(val);
      _loader.unload();
      Get.back();
      Get.snackbar('Success', 'New user created.');
    } else {
      await firestore.collection('users').doc(doc.id).update(val);
      _loader.unload();
      Get.snackbar('Success', 'User details updated.');
      userController.sendNotification('Update Notification', 'Your details have been updated.', user.value.id);
    }
    user.value.image = val['image'];
    user.refresh();
  }
}
