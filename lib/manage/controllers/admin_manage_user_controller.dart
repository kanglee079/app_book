import 'package:app_book/manage/state/personal_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';

class AdminManageUserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final state = PersonalState();

  @override
  void onInit() {
    super.onInit();
    fetchAllUsers();
  }

  void fetchAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();
      List<UserModel> users = [];
      for (var doc in querySnapshot.docs) {
        users.add(UserModel.fromMap(doc.data() as Map<String, dynamic>));
      }
      state.listUserInfo.assignAll(users);
    } catch (e) {
      print(e);
    }
  }
}
