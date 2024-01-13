import 'package:get/get.dart';

import '../../models/book_model.dart';

class BookState {
  RxList<Book> listBook = <Book>[].obs;
  RxList<Book> featuredBooks = <Book>[].obs;
}
