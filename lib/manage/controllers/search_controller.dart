import 'dart:async';

import 'package:app_book/models/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../apps/route/route_name.dart';

class SearchBookController extends GetxController {
  RxList<Book> searchResults = <Book>[].obs;
  Timer? _debounce;

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      performSearch(query);
    });
  }

  Future<void> performSearch(String query) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('books')
          .where('bookName', isEqualTo: query)
          .get();

      List<Book> books = querySnapshot.docs
          .map((doc) => Book.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      searchResults.assignAll(books);
    } catch (e) {
      print(e);
    }
  }

  void transToDetailBook(Book book) {
    Get.toNamed(
      RouterName.detailBook,
      arguments: book,
    );
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}
