import 'package:app_book/apps/route/route_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../models/chat_room.dart';
import '../../models/message.dart';

class ChatController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<ChatRoom> chatRooms = <ChatRoom>[].obs;
  RxList<Message> messages = <Message>[].obs;

  Future<void> createChatRoom(String userId, String adminId) async {
    String chatRoomId = 'chatRoom_${userId}_$adminId';
    ChatRoom newChatRoom = ChatRoom(
      roomId: chatRoomId,
      userId: userId,
      adminId: adminId,
      messages: [],
    );

    await firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .set(newChatRoom.toMap());
  }

  Future<void> createOrJoinChatRoom(String userId, String adminId) async {
    String chatRoomId = 'chatRoom_${userId}_$adminId';

    final existingRoom =
        await firestore.collection('chatRooms').doc(chatRoomId).get();
    if (!existingRoom.exists) {
      await createChatRoom(userId, adminId);
    }

    Get.toNamed(RouterName.userChat, arguments: chatRoomId);
  }

  Future<void> sendMessage(
      String chatRoomId, String messageText, String senderId) async {
    Message newMessage = Message(
      messageId: firestore
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages')
          .doc()
          .id,
      senderId: senderId,
      text: messageText,
      timestamp: DateTime.now(),
      isRead: false,
    );

    await firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  void fetchMessages(String chatRoomId) {
    firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .listen((snapshot) {
      messages
          .assignAll(snapshot.docs.map((doc) => Message.fromMap(doc.data())));
    });
  }

  void fetchChatRoomsForAdmin(String adminId) {
    firestore
        .collection('chatRooms')
        .where('adminId', isEqualTo: adminId)
        .snapshots()
        .listen((snapshot) {
      chatRooms
          .assignAll(snapshot.docs.map((doc) => ChatRoom.fromMap(doc.data())));
    });
  }

  Future<void> updateMessageStatus(String chatRoomId, String messageId) async {
    await firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .doc(messageId)
        .update({'isRead': true});
  }
}
