import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:app_book/manage/controllers/nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigatorPage extends GetView<NavController> {
  const NavigatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.bottomNavIndex,
          children: controller.listPage,
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          backgroundColor: Theme.of(context).hintColor,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          icons: controller.listIcon,
          activeColor: const Color(0xFFFF9900),
          iconSize: 30,
          activeIndex: controller.bottomNavIndex,
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          onTap: controller.changeNav,
        ),
      ),
    );
  }
}
