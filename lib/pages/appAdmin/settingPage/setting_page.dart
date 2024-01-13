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
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(Icons.menu),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            // Container(
            //   width: 120,
            //   height: 120,
            //   decoration: BoxDecoration(
            //     color: Colors.amber,
            //     borderRadius: BorderRadius.circular(70),
            //   ),
            // ),
            // const SizedBox(height: 10),
            // const Text("Admin Name"),
            // ItemAdminPage(
            //   nameItem: "Tài Khoản",
            //   ontap: () {},
            // ),
            // ItemAdminPage(
            //   nameItem: "Ngôn Ngữ",
            //   ontap: () {},
            // ),
            // ItemAdminPage(
            //   nameItem: "Theme",
            //   ontap: () {},
            // ),
            ItemAdminPage(
              nameItem: "Chuyển sang giao diện User",
              ontap: controller.transToNavUser,
            ),
            ItemAdminPage(
              nameItem: "Đăng Xuất",
              ontap: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Xác Nhận'),
                    content:
                        const Text('Bạn có chắc chắn muốn đăng xuất không?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Hủy'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Đăng Xuất'),
                        onPressed: () {
                          controller.logout();
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
