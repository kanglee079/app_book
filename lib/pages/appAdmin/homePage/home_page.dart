import 'package:app_book/manage/controllers/admin_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/manager_status_widget.dart';

class HomePage extends GetView<AdminHomeController> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    print("home");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Trang Chính",
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
      body: Obx(
        () => Column(
          children: [
            Expanded(
              flex: 1,
              child: ManagerStatusWidget(
                textNameStatus: "Quản lí người dùng",
                text1: "Người dùng hiện tại: ${controller.totalUserCurrent}",
                text2:
                    "Người dùng mới trong ngày: ${controller.totalNewsUserToday}",
                text3: "Tổng người dùng: ${controller.totalUser}",
                icon1: Icons.supervised_user_circle_outlined,
                icon2: Icons.person_add_alt,
                icon3: Icons.summarize_outlined,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 1,
              child: ManagerStatusWidget(
                textNameStatus: "Quản lí sách",
                text1: "Tổng số sách: ${controller.totalBook}",
                text2: "Tổng số thể loại: ${controller.totalCategories}",
                icon1: Icons.book_outlined,
                icon2: Icons.category_outlined,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
