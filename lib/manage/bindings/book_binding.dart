import 'package:app_book/manage/controllers/book_controller.dart';
import 'package:get/get.dart';

class BookBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookController());
  }
}
