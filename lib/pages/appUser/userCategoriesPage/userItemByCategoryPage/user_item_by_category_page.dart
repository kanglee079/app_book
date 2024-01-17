import 'package:app_book/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../manage/controllers/book_controller.dart';
import '../../../../models/book_model.dart';
import '../../../../widgets/item_user_book_by_category.dart';

class UserItemByCategoryPage extends StatefulWidget {
  const UserItemByCategoryPage({super.key});

  @override
  State<UserItemByCategoryPage> createState() => _UserItemByCategoryPageState();
}

class _UserItemByCategoryPageState extends State<UserItemByCategoryPage> {
  Category dataCategory = Get.arguments;

  final controllerBook = Get.find<BookController>();

  late List<Book> booksOfCategory;

  @override
  void initState() {
    booksOfCategory = controllerBook.getBooksByCategory(dataCategory.id ?? "");
    super.initState();
  }

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
              dataCategory.nameCategory ?? "",
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: booksOfCategory.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: booksOfCategory.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(height: 30, color: Colors.grey);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    Book dataBook = booksOfCategory[index];

                    return InkWell(
                      onTap: () {
                        controllerBook.transToDetailBook(dataBook);
                      },
                      child: UserItemByCategory(
                        idBook: dataBook.id,
                        bookName: dataBook.bookName,
                        authorName: dataBook.authorName,
                        desc: dataBook.desc,
                        image: dataBook.photoUrl,
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    "Not yet a Book",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
        ),
      ),
    );
  }
}
