import 'package:flutter/material.dart';

class UserItemByCategory extends StatelessWidget {
  String idBook;
  String? bookName;
  String? authorName;
  String? desc;
  String? image;

  UserItemByCategory({
    super.key,
    required this.bookName,
    required this.authorName,
    required this.desc,
    required this.idBook,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Container(
              height: 195,
              color: Colors.redAccent,
              child: Image.network(
                image ?? "",
                fit: BoxFit.contain,
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
    );
  }
}
