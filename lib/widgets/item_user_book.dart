import 'package:app_book/manage/controllers/category_controller.dart';
import 'package:app_book/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

class ItemUserBook extends StatelessWidget {
  String idBook;
  String? bookName;
  String? authorName;
  String? desc;
  String? image;
  String? idCategory;

  ItemUserBook({
    super.key,
    required this.bookName,
    required this.authorName,
    required this.desc,
    required this.idBook,
    required this.image,
    required this.idCategory,
  });

  @override
  Widget build(BuildContext context) {
    final controllerCategory = Get.find<CategoryController>();
    Category? dataCategory =
        controllerCategory.getCategoryById(idCategory ?? "");
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Image.network(
                  image ?? "",
                  fit: BoxFit.contain,
                ),
                const Positioned(
                  top: 5,
                  left: 5,
                  child: LikeButton(
                    size: 30,
                  ),
                ),
                Positioned(
                  right: 1,
                  child: Container(
                    width: 100,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        dataCategory?.nameCategory ?? "",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            bookName ?? "",
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Text(
            authorName ?? "",
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
