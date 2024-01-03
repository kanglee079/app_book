import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../stores/user_store.dart';

class PdfViewController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserStore _userStore = Get.find<UserStore>();
  final pdfViewerController = PdfViewerController().obs;

  var currentPage = 1.obs;
  var totalPages = 0.obs;

  @override
  void onInit() {
    super.onInit();
    ever(currentPage, handlePageChanged);
  }

  void initPdfViewer(String bookId) async {
    int savedPage = await getSavedPage(bookId);
    pdfViewerController.value.jumpToPage(savedPage);
  }

  Future<void> addCurrentPageBook(String bookId, int currentPage) async {
    await _firestore
        .collection("users")
        .doc(_userStore.userInfo.id)
        .collection('bookmarks')
        .doc(bookId)
        .set({'currentPage': currentPage});
  }

  Future<int> getSavedPage(String idBook) async {
    var document = await _firestore
        .collection("users")
        .doc(_userStore.userInfo.id)
        .collection('bookmarks')
        .doc(idBook)
        .get();

    if (document.exists) {
      return document.data()?['currentPage'] ?? 1;
    }
    return 1;
  }

  void onPageChanged(PdfPageChangedDetails details) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      currentPage.value = details.newPageNumber;
    });
  }

  void onDocumentLoaded(PdfDocumentLoadedDetails details) {
    totalPages.value = details.document.pages.count;
  }

  void jumpToFirstPage() {
    pdfViewerController.value.jumpToPage(1);
  }

  void handlePageChanged(int page) {}
}
