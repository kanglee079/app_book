import 'package:app_book/manage/controllers/book_controller.dart';
import 'package:app_book/widgets/search_book.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../models/book_model.dart';
import '../../../widgets/item_user_book.dart';

class UserHomePage extends GetView<BookController> {
  const UserHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            Icon(
              Icons.book,
              size: 35,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 5),
            Text(
              "Home Page",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBook(
              contentSearch: "Search your book",
              icon: Icons.search,
            ),
            const SizedBox(height: 20),
            Text(
              "Popular Book",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Obx(
              () => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1 / 1.9,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.state.listBook.length,
                itemBuilder: (BuildContext context, int index) {
                  List<Book> listBook = controller.state.listBook;
                  return InkWell(
                    onTap: () {
                      controller.transToDetailBook(listBook[index]);
                    },
                    child: ItemUserBook(
                      idCategory: listBook[index].idCategory,
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
          ],
        ),
      ),
    );
  }
}
