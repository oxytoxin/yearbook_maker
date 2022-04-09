import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yearbook_maker/pages/splash_screen/splash_screen_controller.dart';

class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Scaffold(
        body: controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(padding: const EdgeInsets.all(8.0), child: Container()),
      ),
    ));
  }
}
