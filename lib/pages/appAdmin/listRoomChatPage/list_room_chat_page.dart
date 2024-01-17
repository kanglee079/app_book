import 'package:app_book/apps/route/route_name.dart';
import 'package:app_book/manage/stores/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../manage/controllers/chat_controller.dart';

class ListRoomChatPage extends StatelessWidget {
  const ListRoomChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(ChatController());
    final adminId = UserStore.to.userInfo.id;

    // Lấy danh sách phòng chat dành cho admin
    chatController.fetchChatRoomsForAdmin(adminId!);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách phòng chat"),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: chatController.chatRooms.length,
          itemBuilder: (context, index) {
            final room = chatController.chatRooms[index];
            return InkWell(
              onTap: () {
                Get.toNamed(RouterName.adminChatPage, arguments: room.roomId);
              },
              child: Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Màu viền
                  borderRadius: BorderRadius.circular(12), // Bán kính bo góc
                  color: Colors.white, // Màu nền của Container
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Phòng chat với: ${room.userId}'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
