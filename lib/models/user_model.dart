import 'dart:convert';

class UserModel {
  String? id;
  String role;
  String? userName;
  String? email;
  String? photoUrl;
  DateTime? dateTime;

  UserModel({
    this.id,
    this.userName,
    this.email,
    this.photoUrl,
    this.dateTime,
    this.role = 'isUser',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role,
      'userName': userName,
      'email': email,
      'photoUrl': photoUrl,
      'dateTime': dateTime?.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      role: map['role'] ?? 'isUser',
      userName: map['userName'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      dateTime: map['dateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateTime'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
