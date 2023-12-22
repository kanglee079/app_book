import 'package:app_book/manage/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/item_setting_page.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Mục quản trị",
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(70),
              ),
            ),
            const SizedBox(height: 10),
            const Text("Admin Name"),
            ItemAdminPage(
              nameItem: "Tài Khoản",
              ontap: () {},
            ),
            ItemAdminPage(
              nameItem: "Ngôn Ngữ",
              ontap: () {},
            ),
            ItemAdminPage(
              nameItem: "Theme",
              ontap: () {},
            ),
            ItemAdminPage(
              nameItem: "Chuyển sang giao diện User",
              ontap: controller.transToNavUser,
            ),
            ItemAdminPage(
              nameItem: "Đăng Xuất",
              ontap: controller.logout,
            ),
          ],
        ),
      ),
    );
  }
}
