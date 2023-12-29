import 'package:app_book/apps/helper/showToast.dart';
import 'package:app_book/manage/controllers/pdf_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatefulWidget {
  const PdfViewerPage({super.key});

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  final pdfViewController = Get.find<PdfViewController>();
  int _currentPage = 1;
  int _totalPages = 0;

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    String pdfUrl = data['url'];
    String bookId = data['id'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Đọc sách"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              pdfViewController.addCurrentPageBook(bookId, _currentPage);
              showToastSuccess("Đã lưu lại số trang");
            },
          ),
        ],
      ),
      body: Container(
        child: SfPdfViewer.network(
          pdfUrl ?? "",
          controller: _pdfViewerController,
          onPageChanged: (PdfPageChangedDetails details) {
            setState(() {
              _currentPage = details.newPageNumber;
            });
          },
          onDocumentLoaded: (PdfDocumentLoadedDetails details) {
            setState(() {
              _totalPages = details.document.pages.count;
            });
          },
          canShowScrollHead: false,
          canShowScrollStatus: false,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFB6C7D1),
        onPressed: () {
          _pdfViewerController.jumpToPage(1);
        },
        child: const Icon(Icons.first_page),
      ),
      bottomNavigationBar: Container(
        height: 100,
        color: const Color(0xFFB6C7D1),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            'Trang $_currentPage / $_totalPages',
          ),
        ),
      ),
    );
  }
}
