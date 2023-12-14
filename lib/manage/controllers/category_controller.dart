import 'dart:async';

import 'package:app_book/apps/helper/randomId.dart';
import 'package:app_book/manage/state/category_state.dart';
import 'package:app_book/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../apps/route/route_name.dart';

class CategoryController extends GetxController {
  final state = CategoryState();
  late StreamSubscription listen;

  @override
  void onReady() {
    super.onReady();

    listen = FirebaseFirestore.instance
        .collection("categories")
        .withConverter(
            fromFirestore: (snapshot, _) => Category.fromMap(snapshot.data()!),
            toFirestore: (Category cate, _) => cate.toMap())
        .snapshots()
        .listen(
      (value) {
        state.listCategory.clear();
        if (value.docs.isNotEmpty) {
          for (var e in value.docs) {
            state.listCategory.add(e.data());
          }
        }
      },
    );
  }

  void transToAddCategory() {
    Get.toNamed(RouterName.addCaterogy);
  }

  void transToEditCategory(String idCategory) {
    Get.toNamed(RouterName.editCategory, arguments: idCategory);
  }

  void addCategory(String nameCategory) {
    Category data =
        Category(nameCategory: nameCategory, id: generateRandomIdBook());

    FirebaseFirestore.instance
        .collection("categories")
        .withConverter(
            fromFirestore: (snapshot, _) => Category.fromMap(snapshot.data()!),
            toFirestore: (Category cate, _) => cate.toMap())
        .doc(data.id)
        .set(data);
  }

  void deleteCategory(String idCategory) {
    FirebaseFirestore.instance
        .collection("categories")
        .withConverter(
            fromFirestore: (snapshot, _) => Category.fromMap(snapshot.data()!),
            toFirestore: (Category cate, _) => cate.toMap())
        .doc(idCategory)
        .delete();
  }

  void updateCategory(String idCategory, Category category) {
    FirebaseFirestore.instance
        .collection("categories")
        .withConverter(
            fromFirestore: (snapshot, _) => Category.fromMap(snapshot.data()!),
            toFirestore: (Category cate, _) => cate.toMap())
        .doc(idCategory)
        .update(category.toMap());
  }

  @override
  void onClose() {
    listen.cancel();

    super.onClose();
  }
}
