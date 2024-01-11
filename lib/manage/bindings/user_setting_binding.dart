import 'package:app_book/manage/controllers/user_setting_controller.dart';
import 'package:get/get.dart';

class UserSettingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserSettingController());
  }
}
