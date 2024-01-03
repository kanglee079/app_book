import 'package:app_book/manage/controllers/setting_controller.dart';
import 'package:app_book/widgets/item_setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPersonPage extends GetView<SettingController> {
  const UserPersonPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            Icon(
              Icons.person,
              size: 35,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 5),
            Text(
              "Personal Page",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Color(0xFFFF9900),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
            ),
            Text(
              "Name User",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            ItemAdminPage(
              nameItem: "Info User",
              ontap: () {},
            ),
            ItemAdminPage(
              nameItem: "Info User",
              ontap: () {},
            ),
            ItemAdminPage(
              nameItem: "Info User",
              ontap: () {},
            ),
            ItemAdminPage(
              nameItem: "Info User",
              ontap: () {},
            ),
            ItemAdminPage(
              nameItem: "Logout",
              ontap: () {
                showDialog(
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
