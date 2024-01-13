import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../apps/route/route_name.dart';
import '../../models/user_model.dart';
import '../state/personal_state.dart';
import '../stores/user_store.dart';

class UserSettingController extends GetxController {
  final state = PersonalState();

  UserModel userInfo = UserStore.to.userInfo;
  RxString displayName = UserStore.to.userName.obs;
  RxString emailUser = UserStore.to.userEmail.obs;
  RxString photoUrl = UserStore.to.photoUrl.obs;
  RxString role = UserStore.to.role.obs;

  void logout() {
    Get.dialog(
      AlertDialog(
        title: const Text('Đăng xuất'),
        content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Hủy',
              style: TextStyle(
                color: Color(0xff343434),
                fontSize: 18,
              ),
            ),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: const Text(
              'Đồng ý',
              style: TextStyle(
                color: Color(0xff343434),
                fontSize: 18,
              ),
            ),
            onPressed: () {
              UserStore.to.logout().then((value) {
                Get.offAndToNamed(RouterName.login);
              });
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Future<void> updateProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File file = File(image.path);
      String filePath =
          'user_images/${userInfo.id}/${DateTime.now().millisecondsSinceEpoch}_${image.name}';

      try {
        TaskSnapshot snapshot =
            await FirebaseStorage.instance.ref().child(filePath).putFile(file);

        String downloadUrl = await snapshot.ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userInfo.id)
            .update({'photoUrl': downloadUrl});

        UserStore.to.updateUserPhotoUrl(downloadUrl);
        photoUrl.value = downloadUrl;
      } catch (e) {
        print("Lỗi");
      }
    }
  }
}
