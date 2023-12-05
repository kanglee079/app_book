import 'package:app_book/apps/const/key.dart';
import 'package:app_book/apps/route/route_name.dart';
import 'package:app_book/manage/services/store_service.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  login() {
    Get.offAndToNamed(RouterName.nav);
    StoreService.to.setString(MyKey.TOKEN_USER, "hello");
  }
}
