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
  int _currentPage = 1;
  int _totalPages = 0;

  @override
  Widget build(BuildContext context) {
    String? pdfUrl = Get.arguments;
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
            onPressed: () {},
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
