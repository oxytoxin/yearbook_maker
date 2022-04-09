import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:yearbook_maker/models/yearbook.dart';
import 'package:yearbook_maker/shared/loader.dart';

class AdminYearbooksListController extends GetxController {
  var loading = true.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<Yearbook> yearbooks = RxList.empty();
  final Loader _loader = Get.find();
  @override
  void onInit() {
    getYearbooks();
    super.onInit();
  }

  void getYearbooks() {
    Stream<QuerySnapshot> stream = firestore.collection('yearbooks').snapshots();
    yearbooks.bindStream(stream.map((q) => q.docs.map((yearbook) => Yearbook.fromDocumentSnapshot(yearbook)).toList()));
    loading.value = false;
  }

  void deleteYearbook(Yearbook yearbook) async {
    _loader.load();
    await firestore.collection('yearbooks').doc(yearbook.id).delete();
    _loader.unload();
    Get.snackbar('Success', 'Yearbook deleted.');
  }
}
