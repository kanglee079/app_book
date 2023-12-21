import 'dart:async';

import 'package:app_book/manage/state/favorite_book.dart';
import 'package:app_book/models/book_model.dart';
import 'package:get/get.dart';

class FavoriteBookController extends GetxController {
  final state = FavoriteBookState();

  @override
  void onReady() {
    state.listFavoriteBook;
    super.onReady();
  }

  Future<bool> addFavoriteBook(Book book) async {
    if (book.id.isNotEmpty) {
      state.listFavoriteBook.add(book);
      return true;
    } else {
      print("err");
      return false;
    }
  }
}
