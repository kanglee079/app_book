import 'package:get/get.dart';

class AdminManageUserBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AdminManageUserBinding());
  }
}
