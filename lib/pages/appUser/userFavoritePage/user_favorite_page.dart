import 'package:app_book/manage/controllers/favorite_book_controller.dart';
import 'package:app_book/widgets/item_user_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Obx(
          () => GridView.custom(
            gridDelegate: SliverWovenGridDelegate.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              pattern: [
                const WovenGridTile(1),
                const WovenGridTile(
                  5 / 7,
                  crossAxisRatio: 0.9,
                  alignment: AlignmentDirectional.centerEnd,
                ),
              ],
            ),
            childrenDelegate: SliverChildBuilderDelegate(
              childCount: controller.state.listFavoriteBook.length,
              (context, index) => ItemUserBook(
                idCategory: controller.state.listFavoriteBook[index].idCategory,
                bookName: controller.state.listFavoriteBook[index].bookName,
                authorName: controller.state.listFavoriteBook[index].authorName,
                desc: controller.state.listFavoriteBook[index].desc,
                idBook: controller.state.listFavoriteBook[index].id,
                image: controller.state.listFavoriteBook[index].photoUrl,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
