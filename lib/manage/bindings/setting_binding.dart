import 'package:app_book/manage/controllers/setting_controller.dart';
import 'package:get/get.dart';

class SettingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SettingController());
  }
}
