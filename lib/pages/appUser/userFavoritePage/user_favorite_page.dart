import 'package:app_book/manage/controllers/favorite_book_controller.dart';
import 'package:app_book/widgets/item_favorite_book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/book_model.dart';

class UserFavoritePage extends GetView<FavoriteBookController> {
  const UserFavoritePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            Icon(
              Icons.favorite,
              size: 35,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 5),
            Text(
              "Favorite Page",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.state.listFavoriteBook.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(height: 20, color: Colors.white);
            },
            itemBuilder: (BuildContext context, int index) {
              List<Book> listBook = controller.state.listFavoriteBook;
              return InkWell(
                onTap: () {},
                child: ItemFavoriteBook(
                  bookName: listBook[index].bookName,
                  authorName: listBook[index].authorName,
                  desc: listBook[index].desc,
                  idBook: listBook[index].id,
                  image: listBook[index].photoUrl,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
