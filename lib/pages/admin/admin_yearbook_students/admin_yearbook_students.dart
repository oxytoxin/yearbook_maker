import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yearbook_maker/pages/admin/admin_yearbook_students/admin_yearbook_students_controller.dart';

class AdminYearbookStudents extends GetView<AdminYearbookStudentsController> {
  const AdminYearbookStudents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('YEARBOOK STUDENTS'),
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
                      'Unassigned Students',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: ListView(children: [
                        ...controller.students
                            .where((student) =>
                                !controller.yearbookController.yearbook.value.students.contains(student.id))
                            .map(
                              (student) => ListTile(
                                onLongPress: () {
                                  controller.addUser(student);
                                },
                                onTap: () {
                                  Get.toNamed('/admin/edit_user/${student.id}');
                                },
                                title: Text(student.fullName),
                              ),
                            ),
                      ]),
                    ),
                    const Text(
                      'Assigned Students',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: ListView(children: [
                        ...controller.students
                            .where(
                                (student) => controller.yearbookController.yearbook.value.students.contains(student.id))
                            .map(
                              (student) => ListTile(
                                onTap: () {
                                  Get.toNamed('/admin/edit_user/${student.id}');
                                },
                                onLongPress: () {
                                  controller.removeUser(student);
                                },
                                title: Text(student.fullName),
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
