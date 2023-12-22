import 'package:app_book/apps/const/key.dart';
import 'package:app_book/manage/services/store_service.dart';
import 'package:app_book/models/user_model.dart';
import 'package:get/get.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  final _isLogin = false.obs;
  final _token = "".obs;
  final _info = UserModel().obs;

  bool get isLogin => _isLogin.value;
  String get token => _token.value;
  UserModel get userInfo => _info.value;
  String get userRole => _info.value.role;

  @override
  void onInit() async {
    super.onInit();
    String key = await StoreService.to.getString(MyKey.TOKEN_USER);
    if (key.isNotEmpty) {
      _isLogin.value = true;
    }
  }

  Future<void> login(UserModel user) async {
    _info.value.role = user.role;
    _info.value = user;
    _isLogin.value = true;
    StoreService.to.setString(MyKey.TOKEN_USER, "TOKEN_USER");
  }

  Future<void> logout() async {
    _isLogin.value = false;
    _token.value = "";
    _info.value = UserModel();
    StoreService.to.clean(MyKey.TOKEN_USER);
  }
}
