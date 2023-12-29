import 'package:app_book/manage/controllers/favorite_book_controller.dart';
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.state.listFavoriteBook.length,
          itemBuilder: (context, index) {
            Book book = controller.state.listFavoriteBook[index];
            return ListTile(
              title: Text(book.bookName ?? ""),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  controller.removeFavoriteBookFromFirebase(book.id);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
