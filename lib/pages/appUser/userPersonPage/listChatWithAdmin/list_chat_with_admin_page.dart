import 'package:app_book/manage/controllers/chat_controller.dart';
import 'package:app_book/manage/controllers/user_setting_controller.dart';
import 'package:app_book/manage/stores/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListChatwithAdminPage extends GetView<UserSettingController> {
  const ListChatwithAdminPage({super.key});
  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(ChatController());
    final userId = UserStore.to.userInfo.id;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách Admin"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView.separated(
          itemCount: controller.adminUsers.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(height: 20, color: Colors.grey);
          },
          itemBuilder: (BuildContext context, int index) {
            final dataAdmin = controller.adminUsers[index];
            return ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.amber),
              ),
              onPressed: () {
                chatController.createOrJoinChatRoom(userId!, dataAdmin.id!);
              },
              child: Text(
                "Chat with Admin: ${dataAdmin.userName}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
          },
        ),
      ),
    );
  }
}
