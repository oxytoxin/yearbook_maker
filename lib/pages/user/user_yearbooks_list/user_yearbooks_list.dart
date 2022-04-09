import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yearbook_maker/pages/user/user_yearbooks_list/user_yearbooks_list_controller.dart';

class UserYearbooksList extends GetView<UserYearbooksListController> {
  const UserYearbooksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('YEARBOOKS LIST'),
        ),
        body: controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    controller.yearbooks.isEmpty
                        ? const Center(
                            child: Text(
                              'No Yearbooks Created.',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Container(),
                    ...controller.yearbooks.map(
                      (yearbook) => ListTile(
                        onTap: () {
                          Get.toNamed('/admin/yearbook_preview/' + yearbook.id);
                        },
                        title: Text(yearbook.schoolYear),
                        subtitle: Text(yearbook.title),
                      ),
                    )
                  ],
                )),
      ),
    ));
  }
}
