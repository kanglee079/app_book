import 'package:app_book/manage/controllers/category_controller.dart';
import 'package:app_book/manage/controllers/favorite_book_controller.dart';
import 'package:app_book/models/category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:shimmer/shimmer.dart';

import '../models/book_model.dart';

class ItemFeaturedBook extends StatelessWidget {
  String idBook;
  String? bookName;
  String? authorName;
  String? desc;
  String? image;
  String? idCategory;

  ItemFeaturedBook({
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

    final controllerFavorite = Get.find<FavoriteBookController>();
    // bool isLiked = controllerFavorite.isBookFavorite(idBook);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        border: Border.all(
          width: 1,
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: image ?? "",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.grey,
                      child: const Text(
                        '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Positioned(
                    top: 5,
                    left: 25,
                    child: Obx(
                      () {
                        bool isLiked =
                            controllerFavorite.isBookFavorite(idBook);
                        return LikeButton(
                          size: 30,
                          isLiked: isLiked,
                          onTap: (isLiked) async {
                            Book book = Book(
                              id: idBook,
                              bookName: bookName,
                              authorName: authorName,
                              desc: desc,
                              photoUrl: image,
                              idCategory: idCategory,
                            );
                            controllerFavorite.toggleFavoriteBook(book);
                            return !isLiked;
                          },
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: 19,
                    child: Container(
                      width: 80,
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
      ),
    );
  }
}
