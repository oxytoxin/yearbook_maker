import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:yearbook_maker/pages/admin/admin_edit_yearbook/admin_edit_yearbook_controller.dart';

class AdminEditYearbook extends GetView<AdminEditYearbookController> {
  AdminEditYearbook({Key? key}) : super(key: key);
  final _formkey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(controller.yearbook.value.id == '' ? 'CREATE YEARBOOK' : 'EDIT YEARBOOK'),
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
                      FormBuilderTextField(
                        name: 'title',
                        decoration: const InputDecoration(
                          hintText: 'Title',
                          labelText: 'Title',
                        ),
                        initialValue: controller.yearbook.value.title,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBuilderTextField(
                        name: 'schoolYear',
                        decoration: const InputDecoration(
                          hintText: 'School Year',
                          labelText: 'School Year',
                        ),
                        initialValue: controller.yearbook.value.schoolYear,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBuilderTextField(
                        name: 'theme',
                        decoration: const InputDecoration(
                          hintText: 'Theme',
                          labelText: 'Theme',
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        initialValue: controller.yearbook.value.theme,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBuilderTextField(
                        name: 'prayer',
                        decoration: const InputDecoration(
                          hintText: 'Prayer',
                          labelText: 'Prayer',
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        initialValue: controller.yearbook.value.prayer,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBuilderTextField(
                        name: 'song',
                        decoration: const InputDecoration(
                          hintText: 'Song',
                          labelText: 'Song',
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        initialValue: controller.yearbook.value.song,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      controller.yearbook.value.id == ''
                          ? Container()
                          : Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed('/admin/yearbook_teachers/${controller.yearbook.value.id}');
                                    },
                                    child: const Text('TEACHERS'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed('/admin/yearbook_students/${controller.yearbook.value.id}');
                                    },
                                    child: const Text('STUDENTS'),
                                  ),
                                ),
                              ],
                            ),
                      controller.yearbook.value.id == ''
                          ? Container()
                          : const SizedBox(
                              height: 20,
                            ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();
                            controller.save(_formkey.currentState!.value);
                          }
                        },
                        child: Text(controller.yearbook.value.id == '' ? 'CREATE YEARBOOK' : 'SAVE YEARBOOK'),
                      ),
                      controller.yearbook.value.id == ''
                          ? Container()
                          : ElevatedButton(
                              onPressed: () async {
                                if (_formkey.currentState!.validate()) {
                                  _formkey.currentState!.save();
                                  controller.publish(_formkey.currentState!.value);
                                }
                              },
                              child: const Text('PUBLISH YEARBOOK'),
                            ),
                    ],
                  ),
                )),
      ),
    ));
  }
}
