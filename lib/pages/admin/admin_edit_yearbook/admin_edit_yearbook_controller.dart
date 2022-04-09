import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:yearbook_maker/controllers/user_controller.dart';
import 'package:yearbook_maker/models/user.dart';
import 'package:yearbook_maker/models/yearbook.dart';
import 'package:yearbook_maker/shared/loader.dart';

class AdminEditYearbookController extends GetxController {
  var loading = true.obs;
  List<User> students = [];
  List<User> teachers = [];
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
  final UserController userController = Get.find();

  @override
  void onInit() async {
    if (Get.parameters['id']! != 'new') {
      doc = await firestore.collection('yearbooks').doc(Get.parameters['id']!).get();
      yearbook.value = Yearbook.fromDocumentSnapshot(doc);
    }

    super.onInit();
    loading.value = false;
  }

  void save(Map<String, dynamic> values, {publish = false}) async {
    _loader.load();

    var val = Map.of(values);
    if (yearbook.value.id == '') {
      val['published'] = false;
      val['yearbookUrl'] = '';
      val['teachers'] = [];
      val['students'] = [];

      // save yearbook to firestore
      await firestore.collection('yearbooks').add(val);
      _loader.unload();
      Get.back(closeOverlays: true);
      Get.snackbar('Success', 'Yearbook created!');
    } else {
      await firestore.collection('yearbooks').doc(doc.id).update(val);
      if (!publish) {
        _loader.unload();
        Get.back();
        Get.snackbar('Success', 'Yearbook details updated.');
      }
    }
  }

  void publish(Map<String, dynamic> values) async {
    save(values, publish: true);
    if (yearbook.value.students.isEmpty || yearbook.value.teachers.isEmpty) {
      _loader.unload();
      Get.snackbar('Error', 'Yearbook must have students and teachers!');
      return;
    }
    students = [];
    teachers = [];
    var studentDoc =
        await FirebaseFirestore.instance.collection('users').where('__name__', whereIn: yearbook.value.students).get();
    var teacherDoc =
        await FirebaseFirestore.instance.collection('users').where('__name__', whereIn: yearbook.value.teachers).get();
    for (var doc in studentDoc.docs) {
      if (doc.data()['image'] == '') {
        _loader.unload();
        Get.snackbar('Error', 'Some students have no image.');
        return;
      }
      students.add(User.fromDocumentSnapshot(doc));
    }
    for (var doc in teacherDoc.docs) {
      if (doc.data()['image'] == '') {
        _loader.unload();
        Get.snackbar('Error', 'Some teachers have no image.');
        return;
      }
      teachers.add(User.fromDocumentSnapshot(doc));
    }
    Directory? dir = await getTemporaryDirectory();
    for (var student in students) {
      File photo = File("${dir.path}/${student.id}.jpeg");
      await FirebaseStorage.instance.ref('uploads/${student.id}').writeToFile(photo);
    }
    for (var teacher in teachers) {
      File photo = File("${dir.path}/${teacher.id}.jpeg");
      await FirebaseStorage.instance.ref('uploads/${teacher.id}').writeToFile(photo);
    }
    final PdfDocument doc = PdfDocument();
    PdfPage page = doc.pages.add();
    var title = yearbook.value.title;
    PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 40);
    Size size = font.measureString(title);
    page.graphics
        .drawString(title, font, bounds: Rect.fromLTWH(page.getClientSize().width / 2 - size.width / 2, 0, 0, 0));
    var schoolYear = yearbook.value.schoolYear;
    font = PdfStandardFont(PdfFontFamily.helvetica, 28);
    size = font.measureString(schoolYear);
    page.graphics
        .drawString(schoolYear, font, bounds: Rect.fromLTWH(page.getClientSize().width / 2 - size.width / 2, 48, 0, 0));
    page.graphics.drawString(yearbook.value.theme, PdfStandardFont(PdfFontFamily.helvetica, 32),
        bounds: const Rect.fromLTWH(0, 84, 0, 0));
    page = doc.pages.add();
    page.graphics.drawString(
      "Prayer",
      PdfStandardFont(PdfFontFamily.helvetica, 24),
    );
    page.graphics.drawString(yearbook.value.prayer, PdfStandardFont(PdfFontFamily.helvetica, 16),
        bounds: const Rect.fromLTWH(0, 30, 0, 0));
    page = doc.pages.add();
    page.graphics.drawString(
      "Song",
      PdfStandardFont(PdfFontFamily.helvetica, 24),
    );
    page.graphics.drawString(yearbook.value.song, PdfStandardFont(PdfFontFamily.helvetica, 16),
        bounds: const Rect.fromLTWH(0, 30, 0, 0));

    page = doc.pages.add();
    page.graphics.drawString(
      "Students",
      PdfStandardFont(PdfFontFamily.helvetica, 40),
    );

    for (var j = 0; j < students.length; j++) {
      var i = j % 4;
      if (i == 0) {
        page = doc.pages.add();
      }
      double margin = 20;
      double left = (i % 2) * (page.getClientSize().width / 2) + (i % 2) * margin;
      double top = (i < 2 ? 0 : page.getClientSize().height / 2);
      double width = page.getClientSize().width / 2 - margin;
      double height = page.getClientSize().height / 2 - 60;
      page.graphics.drawImage(PdfBitmap(File('${dir.path}/${students[j].id}.jpeg').readAsBytesSync()),
          Rect.fromLTWH(left, top, width, height));
      page.graphics.drawString(students[j].fullName, PdfStandardFont(PdfFontFamily.helvetica, 20),
          bounds: Rect.fromLTWH(left, top + height + 16, width, 0));
    }

    page = doc.pages.add();
    page.graphics.drawString(
      "Teachers",
      PdfStandardFont(PdfFontFamily.helvetica, 40),
    );

    for (var j = 0; j < teachers.length; j++) {
      var i = j % 4;
      if (i == 0) {
        page = doc.pages.add();
      }
      double margin = 20;
      double left = (i % 2) * (page.getClientSize().width / 2) + (i % 2) * margin;
      double width = page.getClientSize().width / 2 - margin;
      double height = page.getClientSize().height / 2 - 60;
      double top = (i < 2 ? 0 : page.getClientSize().height / 2);
      page.graphics.drawImage(PdfBitmap(File('${dir.path}/${teachers[j].id}.jpeg').readAsBytesSync()),
          Rect.fromLTWH(left, top, width, height));
      page.graphics.drawString(teachers[j].fullName, PdfStandardFont(PdfFontFamily.helvetica, 20),
          bounds: Rect.fromLTWH(left, top + height + 16, width, 0));
    }

    var file = await File('${dir.path}/${yearbook.value.title}.pdf').writeAsBytes(doc.save());
    doc.dispose();
    await FirebaseStorage.instance.ref('yearbooks/${yearbook.value.id}').putFile(file);
    var yearbookUrl = await FirebaseStorage.instance.ref('yearbooks/${yearbook.value.id}').getDownloadURL();
    await FirebaseFirestore.instance.collection('yearbooks').doc(yearbook.value.id).update({
      'published': true,
      'yearbookUrl': yearbookUrl,
    });
    userController.sendNotification('Yearbook Published', 'A new yearbook has been published', 'yearbooks');
    _loader.unload();
    Get.offNamed('/admin/yearbook_preview/${yearbook.value.id}');
  }
}
