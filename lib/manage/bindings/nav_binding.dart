import 'package:app_book/manage/controllers/book_controller.dart';
import 'package:app_book/manage/controllers/category_controller.dart';
import 'package:app_book/manage/controllers/nav_controller.dart';
import 'package:app_book/manage/controllers/setting_controller.dart';
import 'package:get/get.dart';

class NavBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(NavController());
    Get.put(BookController());
    Get.put(SettingController());
    Get.put(CategoryController());
  }
}
