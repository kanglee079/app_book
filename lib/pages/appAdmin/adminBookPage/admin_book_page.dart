import 'package:app_book/manage/controllers/book_controller.dart';
import 'package:app_book/widgets/item_book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/book_model.dart';
import '../../../widgets/search_book.dart';

class AdminBookPage extends GetView<BookController> {
  const AdminBookPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Sách",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBook(
                  contentSearch: "Search Your book",
                  icon: Icons.search,
                ),
                const SizedBox(height: 15),
                Text(
                  "Danh sách sách",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
                Obx(
                  () => ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.state.listBook.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(height: 20, color: Colors.white);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      List<Book> listBook = controller.state.listBook;
                      return InkWell(
                        onTap: () {
                          controller
                              .transToReadPdfBook(listBook[index].pdfUrl!);
                        },
                        child: ItemBook(
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.transToAddBook();
          },
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
