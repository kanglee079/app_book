import 'package:app_book/manage/controllers/slider_controller.dart';
import 'package:get/get.dart';

class SliderBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SliderController());
  }
}
