import 'package:app_book/apps/helper/showToast.dart';
import 'package:app_book/manage/controllers/book_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ItemBook extends StatelessWidget {
  String idBook;
  String? bookName;
  String? authorName;
  String? desc;
  String? image;

  ItemBook({
    super.key,
    required this.bookName,
    required this.authorName,
    required this.desc,
    required this.idBook,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final controllerBook = Get.find<BookController>();
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          const SizedBox(width: 2),
          SlidableAction(
            onPressed: (context) {
              controllerBook.transToEditBook(idBook);
            },
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(15),
            icon: Icons.edit,
            label: 'Sửa',
          ),
          const SizedBox(width: 1),
          SlidableAction(
            onPressed: (context) {
              try {
                controllerBook.deleteBook(idBook);
                showToastSuccess("Xoá thành công!");
              } catch (e) {
                showToastError("Xoá thất bại do $e");
              }
            },
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(15),
            icon: Icons.delete,
            label: 'Xoá',
          ),
        ],
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).hintColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: AspectRatio(
                aspectRatio: 1 / 1.5,
                child: CachedNetworkImage(
                  imageUrl: image ?? "",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey,
                    child: const Text(
                      'Loading..',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tên sách: ${bookName ?? ""}",
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Tên tác giả: ${authorName ?? ""}",
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Mô tả: ${desc ?? ""}",
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
