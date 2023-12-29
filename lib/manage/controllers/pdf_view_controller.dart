import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../stores/user_store.dart';

class PdfViewController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final idUser = UserStore.to.userInfo.id;

  final pdfViewerController = PdfViewerController();
  RxInt currentPage = 1.obs;
  RxInt totalPages = 0.obs;

  Future<void> addCurrentPageBook(String idBook, int currentPage) async {
    await _firestore
        .collection("users")
        .doc(idUser)
        .collection('bookmarks')
        .doc(idBook)
        .set(
      {'currentPage': currentPage},
    );
  }

  void onPageChanged(PdfPageChangedDetails details) {
    currentPage.value = details.newPageNumber;
  }

  void onDocumentLoaded(PdfDocumentLoadedDetails details) {
    totalPages.value = details.document.pages.count;
  }

  void jumpToFirstPage() {
    pdfViewerController.jumpToPage(1);
  }
}
