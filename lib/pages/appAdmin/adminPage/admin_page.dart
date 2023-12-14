import 'package:app_book/apps/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/item_admin_page.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});
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
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Get.toNamed(RouterName.adminCategory);
            },
            child: ItemAdminPage(
              nameItem: "Thể loại",
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(RouterName.adminBook);
            },
            child: ItemAdminPage(
              nameItem: "Sách",
            ),
          ),
          InkWell(
            onTap: () {},
            child: ItemAdminPage(
              nameItem: "Người dùng",
            ),
          ),
        ],
      ),
    );
  }
}
