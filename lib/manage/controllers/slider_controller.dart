import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart'; // Đảm bảo bạn đã thêm thư viện uuid vào pubspec.yaml

import '../../models/slider.dart';

class SliderController extends GetxController {
  RxList<SliderImage> sliderImages = RxList<SliderImage>();

  @override
  void onReady() {
    sliderImages.bindStream(listenToSliderImages());
    super.onReady();
  }

  Stream<List<SliderImage>> listenToSliderImages() {
    return FirebaseFirestore.instance
        .collection("sliderImages")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => SliderImage.fromMap(doc.data()))
            .toList());
  }

  Future<void> addSlider({
    required String imageUrl,
    String? title,
    String? description,
  }) async {
    var uuid = const Uuid();
    SliderImage newSlider = SliderImage(
      id: uuid.v4(), // Tạo ID duy nhất cho slider mới
      imageUrl: imageUrl,
      title: title,
      description: description,
    );

    await FirebaseFirestore.instance
        .collection("sliderImages")
        .doc(newSlider.id)
        .set(newSlider.toMap());
  }

  Future<void> updateSliderImage(SliderImage image) async {
    await FirebaseFirestore.instance
        .collection("sliderImages")
        .doc(image.id)
        .update(image.toMap());
  }

  Future<void> deleteSliderImage(String id) async {
    await FirebaseFirestore.instance
        .collection("sliderImages")
        .doc(id)
        .delete();
  }
}
