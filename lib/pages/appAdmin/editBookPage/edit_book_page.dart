import 'package:app_book/apps/helper/showToast.dart';
import 'package:app_book/manage/controllers/book_controller.dart';
import 'package:app_book/manage/controllers/category_controller.dart';
import 'package:app_book/models/book_model.dart';
import 'package:app_book/models/category_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_text_field.dart';
import '../../../widgets/item_dropdown.dart';

class EditBookPage extends StatefulWidget {
  const EditBookPage({
    super.key,
  });

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  String? idBook = Get.arguments as String?;
  String? selectedCategoryId;
  Category? seletedCategory;

  final controllerBook = Get.find<BookController>();
  final controllerCategory = Get.put(CategoryController());

  TextEditingController nameBookController = TextEditingController();
  TextEditingController nameAuthorController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController photoUrlController = TextEditingController();
  TextEditingController pdfUrlController = TextEditingController();

  void loadBookData() async {
    Book currentBook = controllerBook.state.listBook.firstWhere(
      (book) => book.id == idBook,
    );

    nameBookController.text = currentBook.bookName ?? '';
    nameAuthorController.text = currentBook.authorName ?? '';
    descController.text = currentBook.desc ?? '';
    photoUrlController.text = currentBook.photoUrl ?? '';
    pdfUrlController.text = currentBook.pdfUrl ?? '';
    selectedCategoryId = currentBook.idCategory;

    setState(() {});
  }

  @override
  void initState() {
    loadBookData();
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
            "Sửa sách",
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
              ItemDropdown(
                dropDown: DropdownSearch<Category>(
                  popupProps: const PopupProps.menu(
                    showSelectedItems: true,
                  ),
                  items: controllerCategory.state.listCategory,
                  itemAsString: (Category? category) =>
                      category?.nameCategory ?? '',
                  compareFn: (Category? a, Category? b) => a?.id == b?.id,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  onChanged: (Category? newValue) {
                    selectedCategoryId = newValue?.id;
                  },
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                nameField: "Tên sách:",
                icon: Icons.category_outlined,
                controller: nameBookController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                nameField: "Tên tác giả:",
                icon: Icons.attribution_sharp,
                controller: nameAuthorController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                nameField: "Mô tả:",
                icon: Icons.description,
                controller: descController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                nameField: "Đường dẫn hình ảnh:",
                icon: Icons.photo_library_outlined,
                controller: photoUrlController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                nameField: "Đường dẫn PDF:",
                icon: Icons.picture_as_pdf_outlined,
                controller: pdfUrlController,
              ),
            ],
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () async {
            try {
              controllerBook.updateBook(
                idBook!,
                Book(
                  id: idBook!,
                  bookName: nameBookController.text,
                  authorName: nameAuthorController.text,
                  desc: descController.text,
                  photoUrl: photoUrlController.text,
                  pdfUrl: pdfUrlController.text,
                ),
              );
              showToastSuccess("Cập nhật sách thành công!");
            } catch (e) {
              showToastError("Cập nhật thất bại do $e");
            }
          },
          child: Container(
            width: double.infinity,
            height: 55,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Center(
              child: Text(
                "Sửa sách",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
