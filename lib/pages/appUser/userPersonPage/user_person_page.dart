import 'package:app_book/apps/route/route_name.dart';
import 'package:app_book/manage/controllers/user_setting_controller.dart';
import 'package:app_book/widgets/item_setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPersonPage extends GetView<UserSettingController> {
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: controller.updateProfilePicture,
              child: Obx(
                () => Container(
                  width: 100,
                  height: 100,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.network(
                    controller.photoUrl.value,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => Text(
                "Tên: ${controller.displayName.value}",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            ItemAdminPage(
              nameItem: "Info User",
              ontap: () {},
            ),
            ItemAdminPage(
              nameItem: "Change Password",
              ontap: () {},
            ),
            Builder(
              builder: (context) {
                if (controller.role == "isUser") {
                  return ItemAdminPage(
                    nameItem: "Logout",
                    ontap: () {
                      controller.logout();
                    },
                  );
                } else {
                  return ItemAdminPage(
                    nameItem: "Transfer to Admin",
                    ontap: () {
                      Get.offAndToNamed(RouterName.nav);
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
