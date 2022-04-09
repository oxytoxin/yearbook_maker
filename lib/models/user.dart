import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({
    required this.id,
    required this.image,
    required this.password,
    required this.role,
    required this.lastName,
    required this.firstName,
    required this.email,
  });
  String firstName;
  String lastName;
  String role;
  String id;
  String image;
  String password;
  String email;

  User.fromDocumentSnapshot(DocumentSnapshot document)
      : id = document.id,
        firstName = document.get('first_name'),
        lastName = document.get('last_name'),
        role = document.get('role'),
        image = document.get('image'),
        password = document.get('password'),
        email = document.get('email');

  String get fullName => firstName + " " + lastName;
}
