import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader extends GetxController {
  void load() {
    Get.defaultDialog(
      title: 'Loading...',
      barrierDismissible: false,
      content: const CircularProgressIndicator(),
    );
  }

  void unload() {
    if (Get.isDialogOpen != null && Get.isDialogOpen!) {
      Get.close(1);
    }
  }
}
