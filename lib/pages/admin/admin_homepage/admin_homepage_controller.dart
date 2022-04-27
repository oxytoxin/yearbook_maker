import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yearbook_maker/controllers/user_controller.dart';
import 'package:yearbook_maker/models/yearbook.dart';

class AdminHomepageController extends GetxController {
  var loading = true.obs;
  final UserController userController = Get.find();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var totalStudents = 0.obs;
  var totalTeachers = 0.obs;
  RxList<Yearbook> yearbooks = RxList<Yearbook>.empty();

  @override
  void onInit() {
    getYearbooks();
    getStudents();
    super.onInit();
  }

  void logout() {
    GetStorage().remove('user');
    Get.offAllNamed('/login_screen');
  }

  void getStudents() async {
    var students = await firestore.collection('users').where('role', isEqualTo: 'student').get();
    var teachers = await firestore.collection('users').where('role', isEqualTo: 'teacher').get();
    totalStudents.value = students.docs.length;
    totalTeachers.value = teachers.docs.length;
    loading.value = false;
  }

  void getYearbooks() async {
    var stream = firestore
        .collection('yearbooks')
        .where('published', isEqualTo: true)
        .where('yearbookUrl', isNotEqualTo: '')
        .snapshots();
    yearbooks.bindStream(stream.map((q) => q.docs.map((yearbook) => Yearbook.fromDocumentSnapshot(yearbook)).toList()));
    yearbooks.sort((a, b) => b.schoolYear.compareTo(a.schoolYear));
    yearbooks.listen((p0) {
      p0.sort((a, b) => b.schoolYear.compareTo(a.schoolYear));
    });
  }
}
