import 'package:app_book/apps/helper/showToast.dart';
import 'package:app_book/manage/controllers/pdf_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends GetView<PdfViewController> {
  const PdfViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;
    final String bookId = data['id'];
    final String pdfUrl = data['url'];

    controller.initPdfViewer(bookId);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Read Book"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              try {
                controller.addCurrentPageBook(
                    bookId, controller.currentPage.value);
                showToastSuccess("Đã lưu lại số trang");
              } catch (e) {}
            },
          ),
        ],
      ),
      body: Obx(() => SfPdfViewer.network(
            pdfUrl,
            controller: controller.pdfViewerController.value,
            onPageChanged: (details) => controller.onPageChanged(details),
            onDocumentLoaded: (details) => controller.onDocumentLoaded(details),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.jumpToFirstPage(),
        child: const Icon(Icons.first_page),
      ),
      bottomNavigationBar: Obx(
        () => SizedBox(
          height: 100,
          child: Center(
            child: Text(
                'Page ${controller.currentPage} / ${controller.totalPages}'),
          ),
        ),
      ),
    );
  }
}
