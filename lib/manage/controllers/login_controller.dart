import 'package:app_book/apps/helper/showToast.dart';
import 'package:app_book/apps/route/route_name.dart';
import 'package:app_book/manage/services/auth_service.dart';
import 'package:app_book/models/user_model.dart'; // Đảm bảo bạn đã tạo UserModel
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/firebase_service.dart';
import '../stores/user_store.dart';

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
        UserModel? userModel = await FirebaseService().getUser(user.uid);

        if (userModel != null) {
          UserStore.to.login(userModel);
        }

        showToastSuccess('Đăng nhập thành công');
        // StoreService.to.setString(MyKey.TOKEN_USER, user.uid);
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
        UserModel? userModel = await FirebaseService().getUser(user.uid);

        if (userModel != null) {
          UserStore.to.login(userModel);
        }

        showToastSuccess('Đăng nhập bằng Google thành công');
        // StoreService.to.setString(MyKey.TOKEN_USER, user.uid);
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
    Get.offAndToNamed(RouterName.register);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
