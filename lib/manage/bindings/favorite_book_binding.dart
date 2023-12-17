import 'package:app_book/manage/controllers/favorite_book_controller.dart';
import 'package:get/get.dart';

class FavoriteBookBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteBookController());
  }
}
