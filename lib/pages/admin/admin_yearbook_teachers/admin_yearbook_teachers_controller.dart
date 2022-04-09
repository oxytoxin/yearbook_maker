import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:yearbook_maker/models/user.dart';
import 'package:yearbook_maker/pages/admin/admin_edit_yearbook/admin_edit_yearbook_controller.dart';

class AdminYearbookTeachersController extends GetxController {
  var loading = true.obs;
  RxList<User> teachers = RxList.empty();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final AdminEditYearbookController yearbookController = Get.find();
  @override
  void onInit() {
    Stream<QuerySnapshot> stream = firestore.collection('users').where('role', isEqualTo: 'teacher').snapshots();
    teachers.bindStream(stream.map((q) => q.docs.map((d) => User.fromDocumentSnapshot(d)).toList()));
    loading.value = false;
    super.onInit();
  }

  void addUser(User user) async {
    firestore.collection('yearbooks').doc(yearbookController.doc.id).update({
      'teachers': FieldValue.arrayUnion([user.id])
    });
    yearbookController.yearbook.value.teachers.add(user.id);
    yearbookController.yearbook.refresh();
  }

  void removeUser(User user) async {
    firestore.collection('yearbooks').doc(yearbookController.doc.id).update({
      'teachers': FieldValue.arrayRemove([user.id])
    });
    yearbookController.yearbook.value.teachers.remove(user.id);
    yearbookController.yearbook.refresh();
  }
}
