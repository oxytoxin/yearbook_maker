import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:yearbook_maker/models/user.dart';

class AdminUsersListController extends GetxController {
  var loading = true.obs;
  var filter = 'all';
  RxList<User> users = RxList.empty();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    getUsers();
    super.onInit();
  }

  void getUsers() async {
    Stream<QuerySnapshot> stream = firestore.collection('users').snapshots();
    if (filter == 'students') {
      stream = firestore.collection('users').where('role', isEqualTo: 'student').snapshots();
    }
    if (filter == 'teachers') {
      stream = firestore.collection('users').where('role', isEqualTo: 'teacher').snapshots();
    }
    users.bindStream(stream.map((q) => q.docs.map((d) => User.fromDocumentSnapshot(d)).toList()));
    users.sort((a, b) => a.lastName.compareTo(b.lastName));
    users.listen((p0) {
      p0.sort((a, b) => a.lastName.compareTo(b.lastName));
    });
    loading.value = false;
  }
}
