import 'dart:convert';

import 'package:app_book/models/message.dart';

class ChatRoom {
  String? roomId;
  String? userId;
  String? adminId;
  List<Message>? messages;

  ChatRoom({
    this.roomId,
    this.userId,
    this.adminId,
    this.messages,
  });

  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'userId': userId,
      'adminId': adminId,
      'messages': messages?.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      roomId: map['roomId'],
      userId: map['userId'],
      adminId: map['adminId'],
      messages: map['messages'] != null
          ? List<Message>.from(map['messages']?.map((x) => Message.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRoom.fromJson(String source) =>
      ChatRoom.fromMap(json.decode(source));
}
