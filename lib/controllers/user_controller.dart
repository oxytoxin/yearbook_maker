import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:yearbook_maker/models/user.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  Rx<User> user = User(id: '', image: '', password: '', role: '', lastName: '', firstName: '', email: '').obs;

  @override
  void onInit() async {
    FirebaseMessaging.instance.getInitialMessage().then((message) {});
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        Get.snackbar(message.notification!.title!, message.notification!.body!);
      }
    });
    FirebaseMessaging.instance.subscribeToTopic('yearbooks');
    super.onInit();
  }

  void sendNotification(String title, String body, String topic) async {
    http.Response response = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAA0RNQ4lg:APA91bE6sw-GcEQAmfSUEWJEBoz67HltZYbUYWRc2DLocm8y3Bx07HQ0PCkVXngtIfFUhbC5cirNzH4X1AZjMqI37wb9bWk86e83HWOWSc3aQBt98Km6DqAzZ7L1PdYOCxN9lPrFzpz1',
        },
        body: jsonEncode(<String, dynamic>{
          "to": "/topics/$topic",
          'notification': {
            'title': title,
            'body': body,
          }
        }));
  }
}
