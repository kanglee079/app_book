import 'package:app_book/apps/route/route_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../models/chat_room.dart';
import '../../models/message.dart';

class ChatController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<ChatRoom> chatRooms = <ChatRoom>[].obs;
  RxList<Message> messages = <Message>[].obs;

  // Tạo phòng chat mới
  Future<void> createChatRoom(String userId, String adminId) async {
    // Tạo ID cho chat room
    String chatRoomId = 'chatRoom_${userId}_$adminId';
    ChatRoom newChatRoom = ChatRoom(
      roomId: chatRoomId,
      userId: userId,
      adminId: adminId,
      messages: [],
    );

    // Lưu vào Firestore
    await firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .set(newChatRoom.toMap());
  }

  Future<void> createOrJoinChatRoom(String userId, String adminId) async {
    String chatRoomId = 'chatRoom_${userId}_$adminId';

    // Kiểm tra xem phòng chat đã tồn tại hay chưa
    final existingRoom =
        await firestore.collection('chatRooms').doc(chatRoomId).get();
    if (!existingRoom.exists) {
      // Nếu chưa tồn tại, tạo phòng chat mới
      await createChatRoom(userId, adminId);
    }

    // Chuyển hướng người dùng đến phòng chat
    Get.toNamed(RouterName.userChat, arguments: chatRoomId);
  }

  // Gửi tin nhắn mới
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

    // Thêm tin nhắn vào Firestore
    await firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // Lấy danh sách tin nhắn từ Firestore
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

  // Lấy tất cả phòng chat cho một admin cụ thể
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

  // Cập nhật trạng thái của tin nhắn
  Future<void> updateMessageStatus(String chatRoomId, String messageId) async {
    await firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .doc(messageId)
        .update({'isRead': true});
  }
}
