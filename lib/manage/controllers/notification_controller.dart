import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  Future<void> sendNotification(
      String title, String imageUrl, String description) async {
    var url = Uri.parse('https://onesignal.com/api/v1/notifications');
    var header = {
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": "Basic ZmZlMWExNTEtNmM3ZC00ZTNiLTgxZjQtNDIxNDRkMmFiYzY1"
    };

    var request = {
      "app_id": "4ef789ff-548a-4239-9d45-8324237cd02b",
      "headings": {"en": title},
      "contents": {"en": description},
      "big_picture": imageUrl,
      "included_segments": ["Subscribed Users"]
    };

    try {
      var response =
          await http.post(url, headers: header, body: json.encode(request));
      if (response.statusCode == 200) {
        print("Notification sent successfully.");
      } else {
        print(
            "Failed to send notification. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error sending notification: $e");
    }
  }
}
