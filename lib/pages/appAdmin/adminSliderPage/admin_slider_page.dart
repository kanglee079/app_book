import 'package:app_book/apps/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../manage/controllers/slider_controller.dart';
import '../../../widgets/slider_item.dart';

class AdminSliderPage extends GetView<SliderController> {
  const AdminSliderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Sliders",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text(
                  "Danh sách Slider",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
                Obx(() {
                  if (controller.sliderImages.isEmpty) {
                    return const Center(child: Text("Chưa có slider nào."));
                  } else {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.sliderImages.length,
                      separatorBuilder: (_, index) => const Divider(height: 20),
                      itemBuilder: (_, index) {
                        final slider = controller.sliderImages[index];
                        return SliderItemWidget(
                          imageUrl: slider.imageUrl,
                          title: slider.title,
                          description: slider.description,
                          id: slider.id,
                        );
                      },
                    );
                  }
                }),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(RouterName.addSliderPage);
          },
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
