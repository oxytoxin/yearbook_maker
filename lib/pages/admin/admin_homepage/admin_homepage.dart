import 'package:cached_network_image/cached_network_image.dart';
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
                  controller.logout();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const SizedBox(
                height: 28,
              ),
              ListTile(
                onTap: () {
                  Get.toNamed('/admin/homepage');
                },
                title: const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.toNamed('/admin/users_list');
                },
                title: const Text(
                  'Users List',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.toNamed('/admin/yearbooks_list');
                },
                title: const Text(
                  'Yearbooks List',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    CachedNetworkImage(
                      height: 200,
                      imageUrl: controller.userController.user.value.image == ''
                          ? 'https://avatarairlines.com/wp-content/uploads/2020/05/Male-placeholder.jpeg'
                          : controller.userController.user.value.image,
                      placeholder: (context, url) => const SizedBox(
                        height: 200,
                        width: 200,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'First Name',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      controller.userController.user.value.firstName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Text(
                      'Last Name',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      controller.userController.user.value.lastName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Text(
                      'Email Address',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      controller.userController.user.value.email,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Text(
                      'Role',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      controller.userController.user.value.role,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Get.toNamed('/admin/edit_user/${controller.userController.user.value.id}');
                        },
                        child: const Text('EDIT'))
                  ],
                )),
      ),
    ));
  }
}
