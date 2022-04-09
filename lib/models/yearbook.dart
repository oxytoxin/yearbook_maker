import 'package:cloud_firestore/cloud_firestore.dart';

class Yearbook {
  String id;
  String title;
  String schoolYear;
  String theme;
  String prayer;
  String song;
  String yearbookUrl;
  bool published;
  List<dynamic> students;
  List<dynamic> teachers;

  Yearbook({
    required this.id,
    required this.title,
    required this.schoolYear,
    required this.theme,
    required this.prayer,
    required this.song,
    required this.yearbookUrl,
    required this.published,
    required this.students,
    required this.teachers,
  });

  Yearbook.fromDocumentSnapshot(DocumentSnapshot document)
      : id = document.id,
        title = document.get('title'),
        schoolYear = document.get('schoolYear'),
        published = document.get('published'),
        prayer = document.get('prayer'),
        song = document.get('song'),
        theme = document.get('theme'),
        students = document.get('students'),
        teachers = document.get('teachers'),
        yearbookUrl = document.get('yearbookUrl');
}
