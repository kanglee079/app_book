import 'package:app_book/manage/controllers/category_controller.dart';
import 'package:app_book/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserCategoriesPage extends GetView<CategoryController> {
  const UserCategoriesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            Icon(
              Icons.category,
              size: 35,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 5),
            Text(
              "Categories Page",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Obx(
            () => ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.state.listCategory.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(height: 25, color: Colors.white);
              },
              itemBuilder: (BuildContext context, int index) {
                Category dataCategory = controller.state.listCategory[index];
                return InkWell(
                  onTap: () {
                    controller.transToBookWithCategory(dataCategory);
                  },
                  child: AspectRatio(
                    aspectRatio: 1 / 0.17,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.primaries[index % 12].shade500,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dataCategory.nameCategory ?? "",
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              const Icon(Icons.arrow_circle_right_outlined),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
