import 'package:app_book/manage/controllers/category_controller.dart';
import 'package:get/get.dart';

class CategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryController());
  }
}
