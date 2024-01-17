import 'package:app_book/widgets/search_book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../manage/controllers/search_controller.dart';
import '../../../models/book_model.dart';
import '../../../widgets/item_user_book_by_category.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(SearchBookController());
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search Page"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              SearchBook(),
              const SizedBox(height: 15),
              Obx(
                () => ListView.separated(
                  separatorBuilder: (context, index) {
                    return Container(height: 10);
                  },
                  shrinkWrap: true,
                  itemCount: searchController.searchResults.length,
                  itemBuilder: (context, index) {
                    Book book = searchController.searchResults[index];
                    return InkWell(
                      onTap: () {
                        searchController.transToDetailBook(book);
                      },
                      child: UserItemByCategory(
                        idBook: book.id,
                        bookName: book.bookName,
                        authorName: book.authorName,
                        desc: book.desc,
                        image: book.photoUrl,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
