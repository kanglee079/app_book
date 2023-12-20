import 'package:app_book/apps/const/key.dart';
import 'package:app_book/apps/helper/showToast.dart';
import 'package:app_book/apps/route/route_name.dart';
import 'package:app_book/manage/services/auth_service.dart';
import 'package:app_book/manage/services/store_service.dart';
import 'package:app_book/models/user_model.dart'; // Đảm bảo bạn đã tạo UserModel
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/firebase_service.dart';

class LoginController extends GetxController with StateMixin {
  late TextEditingController emailController;
  late GlobalKey<FormState> keyLoginForm;
  late TextEditingController passwordController;
  final RxBool _loading = false.obs;

  bool get loading => _loading.value;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    keyLoginForm = GlobalKey<FormState>();
    passwordController = TextEditingController();
  }

  void login() async {
    if (loading) return;
    _loading.value = true;

    try {
      User? user = await AuthService.to.signInWithEmailPassword(
          emailController.text, passwordController.text);

      if (user != null) {
        showToastSuccess('Đăng nhập thành công');
        StoreService.to.setString(MyKey.TOKEN_USER, user.uid);
        Get.offAndToNamed(RouterName.nav);
      } else {
        showToastError('Thông tin đăng nhập không chính xác');
      }
    } catch (e) {
      showToastError(e.toString());
    } finally {
      _loading.value = false;
    }
  }

  void loginWithGoogle() async {
    if (loading) return;
    _loading.value = true;

    try {
      User? user = await AuthService.to.signInWithGoogle();

      if (user != null) {
        UserModel newUser = UserModel(
          id: user.uid,
          email: user.email,
          userName: user.displayName,
        );

        await FirebaseService().updateUser(newUser);

        showToastSuccess('Đăng nhập bằng Google thành công');
        StoreService.to.setString(MyKey.TOKEN_USER, user.uid);
        Get.offAndToNamed(RouterName.nav);
      } else {
        showToastError('Đăng nhập thất bại');
      }
    } catch (e) {
      showToastError(e.toString());
    } finally {
      _loading.value = false;
    }
  }

  void transToRegisterPage() {
    Get.toNamed(RouterName.register);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
