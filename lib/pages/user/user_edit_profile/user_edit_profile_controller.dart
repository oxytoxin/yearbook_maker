import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yearbook_maker/controllers/user_controller.dart';
import 'package:yearbook_maker/models/user.dart';
import 'package:yearbook_maker/shared/loader.dart';

class UserEditProfileController extends GetxController {
  var loading = true.obs;
  Rx<User> user = User(id: '', image: '', password: '', role: '', lastName: '', firstName: '', email: '').obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late DocumentSnapshot doc;
  GetStorage box = GetStorage();
  final Loader _loader = Get.find();
  final UserController userController = Get.find();

  @override
  void onInit() async {
    doc = await firestore.collection('users').doc(userController.user.value.id).get();
    user.value = User.fromDocumentSnapshot(doc);
    super.onInit();
    loading.value = false;
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
    await firestore.collection('users').doc(doc.id).update(val);
    _loader.unload();
    Get.snackbar('Success', 'User details updated.');
    user.value.image = val['image'];
    user.refresh();
  }
}
