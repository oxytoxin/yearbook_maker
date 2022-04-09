import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yearbook_maker/pages/admin/admin_yearbook_teachers/admin_yearbook_teachers_controller.dart';

class AdminYearbookTeachers extends GetView<AdminYearbookTeachersController> {
  const AdminYearbookTeachers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('YEARBOOK TEACHERS'),
        ),
        body: controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      'Unassigned Teachers',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: ListView(children: [
                        ...controller.teachers
                            .where((teacher) =>
                                !controller.yearbookController.yearbook.value.teachers.contains(teacher.id))
                            .map(
                              (teacher) => ListTile(
                                onLongPress: () {
                                  controller.addUser(teacher);
                                },
                                onTap: () {
                                  Get.toNamed('/admin/edit_user/${teacher.id}');
                                },
                                title: Text(teacher.fullName),
                              ),
                            ),
                      ]),
                    ),
                    const Text(
                      'Assigned Teachers',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: ListView(children: [
                        ...controller.teachers
                            .where(
                                (teacher) => controller.yearbookController.yearbook.value.teachers.contains(teacher.id))
                            .map(
                              (teacher) => ListTile(
                                onLongPress: () {
                                  controller.removeUser(teacher);
                                },
                                onTap: () {
                                  Get.toNamed('/admin/edit_user/${teacher.id}');
                                },
                                title: Text(teacher.fullName),
                              ),
                            ),
                      ]),
                    ),
                  ],
                )),
      ),
    ));
  }
}
