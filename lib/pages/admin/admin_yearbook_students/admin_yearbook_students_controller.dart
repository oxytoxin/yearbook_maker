import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:yearbook_maker/models/user.dart';
import 'package:yearbook_maker/pages/admin/admin_edit_yearbook/admin_edit_yearbook_controller.dart';

class AdminYearbookStudentsController extends GetxController {
  var loading = true.obs;
  RxList<User> students = RxList.empty();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final AdminEditYearbookController yearbookController = Get.find();

  @override
  void onInit() {
    Stream<QuerySnapshot> stream = firestore.collection('users').where('role', isEqualTo: 'student').snapshots();
    students.bindStream(stream.map((q) => q.docs.map((d) => User.fromDocumentSnapshot(d)).toList()));
    loading.value = false;
    print(students);
    super.onInit();
  }

  void addUser(User user) async {
    firestore.collection('yearbooks').doc(yearbookController.doc.id).update({
      'students': FieldValue.arrayUnion([user.id])
    });
    yearbookController.yearbook.value.students.add(user.id);
    yearbookController.yearbook.refresh();
  }

  void removeUser(User user) async {
    firestore.collection('yearbooks').doc(yearbookController.doc.id).update({
      'students': FieldValue.arrayRemove([user.id])
    });
    yearbookController.yearbook.value.students.remove(user.id);
    yearbookController.yearbook.refresh();
  }
}
