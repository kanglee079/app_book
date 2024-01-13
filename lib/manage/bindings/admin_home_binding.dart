import 'package:app_book/manage/controllers/admin_home_controller.dart';
import 'package:get/get.dart';

class AdminHomeBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AdminHomeController());
  }
}
