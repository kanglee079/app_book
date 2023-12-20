import 'package:app_book/pages/appAdmin/adminPage/admin_page.dart';
import 'package:app_book/pages/appAdmin/homePage/home_page.dart';
import 'package:app_book/pages/appAdmin/settingPage/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  final RxInt _bottomNavIndex = 0.obs;
  late List<Widget> listPage;
  late List<IconData> listIcon;

  int get bottomNavIndex => _bottomNavIndex.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listPage = [
      const HomePage(),
      const AdminPage(),
      const SettingPage(),
    ];
    listIcon = const [
      Icons.home,
      Icons.add_home_outlined,
      Icons.settings,
    ];
  }

  changeNav(int index) {
    _bottomNavIndex.value = index;
  }
}
