import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:yearbook_maker/models/user.dart';

class AdminUsersListController extends GetxController {
  var loading = true.obs;
  RxList<User> users = RxList.empty();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    Stream<QuerySnapshot> stream = firestore.collection('users').snapshots();
    users.bindStream(stream.map((q) => q.docs.map((d) => User.fromDocumentSnapshot(d)).toList()));
    loading.value = false;
    super.onInit();
  }
}
