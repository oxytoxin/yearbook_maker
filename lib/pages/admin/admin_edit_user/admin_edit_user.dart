import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yearbook_maker/pages/admin/admin_edit_user/admin_edit_user_controller.dart';

class AdminEditUser extends GetView<AdminEditUserController> {
  AdminEditUser({Key? key}) : super(key: key);
  final _formkey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('EDIT USER'),
          actions: [
            IconButton(
                onPressed: () {
                  controller.deleteUser();
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
          ],
        ),
        body: controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilder(
                  key: _formkey,
                  child: ListView(
                    children: [
                      CachedNetworkImage(
                        height: 200,
                        imageUrl: controller.user.value.image == ''
                            ? 'https://avatarairlines.com/wp-content/uploads/2020/05/Male-placeholder.jpeg'
                            : controller.user.value.image,
                        placeholder: (context, url) => const SizedBox(
                          height: 200,
                          width: 200,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      FormBuilderTextField(
                        name: 'first_name',
                        decoration: const InputDecoration(
                          hintText: 'First Name',
                          labelText: 'First Name',
                        ),
                        initialValue: controller.user.value.firstName,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBuilderTextField(
                        name: 'last_name',
                        decoration: const InputDecoration(
                          hintText: 'Last Name',
                          labelText: 'Last Name',
                        ),
                        initialValue: controller.user.value.lastName,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBuilderTextField(
                        name: 'email',
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          labelText: 'Email',
                        ),
                        initialValue: controller.user.value.email,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.email(context),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBuilderTextField(
                        name: 'password',
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                        ),
                        initialValue: controller.user.value.password,
                        obscureText: true,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.maxLength(context, 16),
                          FormBuilderValidators.minLength(context, 8),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBuilderDropdown(
                        name: 'role',
                        initialValue: controller.user.value.role == '' ? 'admin' : controller.user.value.role,
                        items: const [
                          DropdownMenuItem(
                            child: Text('ADMIN'),
                            value: 'admin',
                          ),
                          DropdownMenuItem(
                            child: Text('TEACHER'),
                            value: 'teacher',
                          ),
                          DropdownMenuItem(
                            child: Text('STUDENT'),
                            value: 'student',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBuilderImagePicker(
                        name: 'image',
                        maxImages: 1,
                        preferredCameraDevice: CameraDevice.rear,
                        loadingWidget: (_) => const CircularProgressIndicator(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              _formkey.currentState!.save();
                              controller.save(_formkey.currentState!.value);
                            }
                          },
                          child: const Text('SAVE')),
                    ],
                  ),
                )),
      ),
    ));
  }
}
