import 'package:app_book/apps/route/route_name.dart';
import 'package:app_book/manage/stores/user_store.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  logout() {
    UserStore.to.logout().then((value) {
      Get.offAllNamed(RouterName.login);
    });
  }

  void transToNavUser() {
    Get.offAndToNamed(RouterName.navUser);
  }
}
