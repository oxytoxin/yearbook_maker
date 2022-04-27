import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yearbook_maker/pages/admin/admin_homepage/admin_homepage_controller.dart';

class AdminHomepage extends GetView<AdminHomepageController> {
  const AdminHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('ADMIN HOMEPAGE'),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed('/admin/edit_user/${controller.userController.user.value.id}');
              },
              icon: const Icon(Icons.person_pin),
            ),
            IconButton(
              onPressed: () {
                controller.logout();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                controller.totalStudents.toString(),
                                style: const TextStyle(fontSize: 48),
                              ),
                              const Text('Total Student Users'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                controller.totalTeachers.toString(),
                                style: const TextStyle(fontSize: 48),
                              ),
                              const Text('Total Teacher Users'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: ListView(
                      children: [
                        ...controller.yearbooks.map(
                          (yearbook) => InkWell(
                            onTap: () {
                              Get.toNamed('/admin/yearbook_preview/' + yearbook.id);
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(yearbook.title),
                                      Text(yearbook.schoolYear),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${yearbook.students.length} students'),
                                      Text('${yearbook.teachers.length} teachers'),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed('/admin/users_list');
                              },
                              child: const Text('MANAGE USERS')),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed('/admin/yearbooks_list');
                              },
                              child: const Text('MANAGE YEARBOOKS')),
                        ),
                      ],
                    ),
                  ],
                )),
      ),
    ));
  }
}
