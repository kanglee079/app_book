import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../manage/controllers/chat_controller.dart';
import '../../../../manage/stores/user_store.dart';

class AdminChatPage extends StatelessWidget {
  const AdminChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chatController = Get.find<ChatController>();
    TextEditingController messageController = TextEditingController();
    String chatRoomId = Get.arguments;
    final adminId = UserStore.to.userInfo.id;

    void sendMessage() {
      if (messageController.text.isNotEmpty) {
        chatController.sendMessage(
            chatRoomId, messageController.text, adminId!);
        messageController.clear();
      }
    }

    chatController.fetchMessages(chatRoomId);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Admin Chat"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: chatController.messages.length,
                  itemBuilder: (context, index) {
                    final message = chatController.messages[index];
                    bool isUserMessage = message.senderId != adminId;

                    return Align(
                      alignment: isUserMessage
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: isUserMessage ? Colors.grey[300] : Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          message.text ?? "",
                          style: TextStyle(
                            color:
                                isUserMessage ? Colors.black87 : Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: sendMessage,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
