import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yearbook_maker/models/yearbook.dart';
import 'package:yearbook_maker/shared/loader.dart';

class AdminYearbookPreviewController extends GetxController {
  var loading = true.obs;
  Rx<Yearbook> yearbook = Yearbook(
      id: '',
      title: '',
      schoolYear: '',
      theme: '',
      prayer: '',
      song: '',
      yearbookUrl: '',
      published: false,
      students: [],
      teachers: []).obs;
  late DocumentSnapshot doc;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Loader _loader = Get.find();
  late File file;

  @override
  void onInit() async {
    doc = await firestore.collection('yearbooks').doc(Get.parameters['id']!).get();
    yearbook.value = Yearbook.fromDocumentSnapshot(doc);
    Directory? dir = await getTemporaryDirectory();
    file = File('${dir.path}/yearbook.pdf');
    await FirebaseStorage.instance.ref('yearbooks/' + yearbook.value.id).writeToFile(file);
    print(file.lengthSync());
    super.onInit();
    loading.value = false;
  }
}
