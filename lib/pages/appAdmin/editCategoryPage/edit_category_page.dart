import 'package:app_book/apps/helper/showToast.dart';
import 'package:app_book/manage/controllers/category_controller.dart';
import 'package:app_book/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_text_field.dart';

class EditCategoryPage extends StatefulWidget {
  const EditCategoryPage({
    super.key,
  });

  @override
  State<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  String? categoryId = Get.arguments as String?;

  final controllerCategory = Get.find<CategoryController>();

  TextEditingController nameCategoryController = TextEditingController();

  void getCategoryById() async {
    Category categoryToEdit = controllerCategory.state.listCategory.firstWhere(
      (category) => category.id == categoryId,
    );
    nameCategoryController.text = categoryToEdit.nameCategory ?? "";
  }

  @override
  void initState() {
    getCategoryById();
    super.initState();
  }

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
            "Sửa thể loại",
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                nameField: "Tên thể loại:",
                icon: Icons.category_outlined,
                controller: nameCategoryController,
              ),
            ],
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () {
            try {
              controllerCategory.updateCategory(
                  categoryId!,
                  Category(
                      id: categoryId,
                      nameCategory: nameCategoryController.text));
              showToastSuccess("Sửa thành công?");
            } catch (e) {
              showToastError("Sửa thất bại $e");
            }
          },
          child: Container(
            width: double.infinity,
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Center(
              child: Text(
                "Sửa thể loại",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
