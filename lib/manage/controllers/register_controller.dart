import 'package:app_book/apps/const/key.dart';
import 'package:app_book/apps/route/route_name.dart';
import 'package:app_book/manage/services/auth_service.dart';
import 'package:app_book/manage/services/store_service.dart';
import 'package:app_book/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../apps/helper/showToast.dart';
import '../services/firebase_service.dart';
import '../stores/user_store.dart';

class RegisterController extends GetxController with StateMixin {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController userNameController;
  late GlobalKey<FormState> keyRegisterForm;
  final RxBool _loading = false.obs;

  bool get loading => _loading.value;

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    userNameController = TextEditingController();
    keyRegisterForm = GlobalKey<FormState>();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    super.onClose();
  }

  void register() async {
    if (loading) return;
    _loading.value = true;

    try {
      User? user = await AuthService.to.signUpWithEmailPassword(
        emailController.text,
        passwordController.text,
        userNameController.text,
      );

      if (user != null) {
        UserModel? userModel = await FirebaseService().getUser(user.uid);

        if (userModel != null) {
          UserStore.to.login(userModel);
        }
        showToastSuccess('Đăng kí thành công');
        StoreService.to.setString(MyKey.TOKEN_USER, user.uid);
        if (UserStore.to.userRole == 'isAdmin') {
          Get.offAndToNamed(RouterName.nav);
        } else {
          Get.offAndToNamed(RouterName.navUser);
        }
      } else {
        Get.snackbar('Error', 'Đăng ký thất bại');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print(e);
    } finally {
      _loading.value = false;
    }
  }

  void registerWithGoogle() async {
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

        await FirebaseService().addUser(newUser);

        StoreService.to.setString(MyKey.TOKEN_USER, user.uid);
        Get.offAndToNamed(RouterName.nav);
      } else {
        Get.snackbar('Error', 'Đăng ký thất bại');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _loading.value = false;
    }
  }
}
