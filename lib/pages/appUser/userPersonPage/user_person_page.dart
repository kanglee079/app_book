import 'package:app_book/widgets/item_setting_page.dart';
import 'package:flutter/material.dart';

import '../../../manage/stores/user_store.dart';

class UserPersonPage extends StatelessWidget {
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
                UserStore.to.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
