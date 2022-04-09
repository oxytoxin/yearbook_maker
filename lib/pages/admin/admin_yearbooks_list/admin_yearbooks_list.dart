import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yearbook_maker/pages/admin/admin_yearbooks_list/admin_yearbooks_list_controller.dart';

class AdminYearbooksList extends GetView<AdminYearbooksListController> {
  const AdminYearbooksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('YEARBOOKS LIST'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed('/admin/edit_yearbook/new');
                },
                icon: const Icon(Icons.add_to_photos_rounded))
          ],
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
                          Get.toNamed('/admin/edit_yearbook/' + yearbook.id);
                        },
                        trailing: IconButton(
                            onPressed: () {
                              if (yearbook.yearbookUrl == '' || !yearbook.published) {
                                Get.snackbar('Error', 'Yearbook not published yet.');
                              } else {
                                Get.toNamed('/admin/yearbook_preview/' + yearbook.id);
                              }
                            },
                            icon: const Icon(
                              Icons.remove_red_eye,
                              color: Colors.teal,
                            )),
                        leading: IconButton(
                            onPressed: () {
                              controller.deleteYearbook(yearbook);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
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
