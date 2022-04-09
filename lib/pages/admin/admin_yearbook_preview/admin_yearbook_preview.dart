import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:yearbook_maker/pages/admin/admin_yearbook_preview/admin_yearbook_preview_controller.dart';

class AdminYearbookPreview extends GetView<AdminYearbookPreviewController> {
  const AdminYearbookPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('PREVIEW YEARBOOK'),
        ),
        body: controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: SfPdfViewer.file(controller.file),
                )),
      ),
    ));
  }
}
