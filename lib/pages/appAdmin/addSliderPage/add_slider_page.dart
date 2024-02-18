import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../apps/helper/showToast.dart';
import '../../../manage/controllers/slider_controller.dart';
import '../../../widgets/custom_text_field.dart';

class AddSliderPage extends StatelessWidget {
  AddSliderPage({super.key});

  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final SliderController sliderController = Get.put(SliderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Thêm Slider",
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                nameField: "URL Hình Ảnh:",
                icon: Icons.link,
                controller: imageUrlController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                nameField: "Tiêu Đề:",
                icon: Icons.text_fields,
                controller: titleController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                nameField: "Mô Tả:",
                icon: Icons.description,
                controller: descriptionController,
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await sliderController.addSlider(
                        imageUrl: imageUrlController.text,
                        title: titleController.text,
                        description: descriptionController.text,
                      );
                      showToastSuccess("Thêm slider thành công!");

                      imageUrlController.clear();
                      titleController.clear();
                      descriptionController.clear();
                    } catch (e) {
                      showToastError("Thêm slider thất bại: $e");
                    }
                  },
                  child: const Text('Thêm Slider'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
