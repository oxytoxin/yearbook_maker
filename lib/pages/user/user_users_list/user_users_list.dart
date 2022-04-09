import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yearbook_maker/pages/user/user_users_list/user_users_list_controller.dart';

class UserUsersList extends GetView<UserUsersListController> {
  const UserUsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('USERS LIST'),
        ),
        body: controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    ...controller.users.map(
                      (user) => ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(user.fullName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(user.email),
                            Text(user.role),
                          ],
                        ),
                        onTap: () {},
                      ),
                    )
                  ],
                )),
      ),
    ));
  }
}
