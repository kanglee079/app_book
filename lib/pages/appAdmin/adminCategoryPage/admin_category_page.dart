import 'package:app_book/manage/controllers/category_controller.dart';
import 'package:app_book/models/category_model.dart';
import 'package:app_book/widgets/item_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminCategoryPage extends GetView<CategoryController> {
  const AdminCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Thể Loại",
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
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => ListView.separated(
              itemCount: controller.state.listCategory.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 20);
              },
              itemBuilder: (BuildContext context, int index) {
                List<Category> listCategory = controller.state.listCategory;
                return ItemCategory(
                  index: index,
                  nameCategory: listCategory[index].nameCategory,
                  idCategory: listCategory[index].id,
                );
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.transToAddCategory,
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
