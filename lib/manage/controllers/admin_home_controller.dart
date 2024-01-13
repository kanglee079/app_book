import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminHomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxInt totalUser = 0.obs;
  RxInt totalNewsUserToday = 0.obs;
  RxInt totalUserCurrent = 0.obs;
  RxInt totalBook = 0.obs;
  RxInt totalCategories = 0.obs;

  @override
  void onInit() {
    super.onInit();
    updateTotalUsersCount();
  }

  Future<int> getTotalUsersCount() async {
    try {
      var querySnapshot = await _firestore.collection('users').get();
      return querySnapshot.docs.length;
    } catch (e) {
      rethrow;
    }
  }

  void updateTotalUsersCount() async {
    int countTotalUser = await getTotalUsersCount();
    int countNewUserTodat = await getTodayUsersCount();
    int countUserCurrent = await getOnlineUsers();
    int countTotalBook = await getTotalCountBook();
    int countTotalCategories = await getTotalCountCategories();
    totalUser.value = countTotalUser;
    totalNewsUserToday.value = countNewUserTodat;
    totalUserCurrent.value = countUserCurrent;
    totalBook.value = countTotalBook;
    totalCategories.value = countTotalCategories;
  }

  Future<int> getTodayUsersCount() async {
    try {
      DateTime now = DateTime.now();
      DateTime startOfToday = DateTime(now.year, now.month, now.day);
      DateTime endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);

      var querySnapshot = await _firestore
          .collection('users')
          .where('createdAt', isGreaterThanOrEqualTo: startOfToday)
          .where('createdAt', isLessThanOrEqualTo: endOfToday)
          .get();

      return querySnapshot.docs.length;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getOnlineUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('isOnline', isEqualTo: true)
          .get();

      return querySnapshot.docs.length;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getTotalCountBook() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('books').get();

      return querySnapshot.docs.length;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getTotalCountCategories() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('categories').get();

      return querySnapshot.docs.length;
    } catch (e) {
      rethrow;
    }
  }
}
