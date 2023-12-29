import 'package:app_book/widgets/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../manage/controllers/book_controller.dart';
import '../../../models/book_model.dart';

class UserDetailBookPage extends StatefulWidget {
  const UserDetailBookPage({
    super.key,
  });

  @override
  State<UserDetailBookPage> createState() => _UserDetailBookPageState();
}

class _UserDetailBookPageState extends State<UserDetailBookPage> {
  Book data = Get.arguments;

  final controllerBook = Get.find<BookController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Book",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.download,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              color: Theme.of(context).hintColor,
              child: Image.network(
                data.photoUrl!,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Book Name: ${data.bookName ?? ""}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Author Name: ${data.authorName ?? ""}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Description: ${data.desc ?? ""}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: ButtonCustom(
        onTap: () {
          controllerBook.transToReadPdfBook(data.pdfUrl ?? "", data.id);
        },
        backgroundColor: Theme.of(context).focusColor,
        textButton: "READ BOOK",
      ),
    );
  }
}
