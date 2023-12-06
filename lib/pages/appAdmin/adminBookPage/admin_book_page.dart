import 'package:app_book/apps/route/route_name.dart';
import 'package:app_book/manage/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/book_model.dart';
import '../../../widgets/item_book.dart';
import '../../../widgets/search_book.dart';

class AdminBookPage extends StatelessWidget {
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
                StreamBuilder(
                  stream: FirebaseService.getAllBooks(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    List<Book> books = snapshot.data!;
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(height: 15, color: Colors.white);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        Book book = snapshot.data![index];
                        return ItemBook(
                          bookName: book.bookName,
                          authorName: book.authorName,
                          desc: book.desc,
                          idBook: book.id,
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(RouterName.addBook);
          },
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
