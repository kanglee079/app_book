import 'dart:async';

import 'package:app_book/apps/helper/randomId.dart';
import 'package:app_book/manage/state/book_state.dart';
import 'package:app_book/models/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../apps/route/route_name.dart';

class BookController extends GetxController {
  final state = BookState();
  late StreamSubscription listen;

  @override
  void onReady() {
    listen = FirebaseFirestore.instance
        .collection("books")
        .withConverter(
            fromFirestore: (snapshot, _) => Book.fromMap(snapshot.data()!),
            toFirestore: (Book book, _) => book.toMap())
        .snapshots()
        .listen(
      (value) {
        state.listBook.clear();
        if (value.docs.isNotEmpty) {
          for (var e in value.docs) {
            state.listBook.add(e.data());
          }
        }
      },
    );
    super.onReady();
  }

  void transToReadPdfBook(String pdfUrl) {
    Get.toNamed(RouterName.pdfView, arguments: pdfUrl);
  }

  void transToAddBook() {
    Get.toNamed(RouterName.addBook);
  }

  void transToEditBook(String idBook) {
    Get.toNamed(RouterName.editBook, arguments: idBook);
  }

  void addBook(
    String? bookName,
    String? authorName,
    String? idCategory,
    String? desc,
    String? photoUrl,
    String? pdfUrl,
  ) {
    Book data = Book(
      id: generateRandomIdBook(),
      bookName: bookName,
      authorName: authorName,
      idCategory: idCategory,
      desc: desc,
      photoUrl: photoUrl,
      pdfUrl: pdfUrl,
    );

    FirebaseFirestore.instance
        .collection("books")
        .withConverter(
            fromFirestore: (snapshot, _) => Book.fromMap(snapshot.data()!),
            toFirestore: (Book book, _) => book.toMap())
        .doc(data.id)
        .set(data);
  }

  void deleteBook(String idBook) {
    FirebaseFirestore.instance
        .collection("books")
        .withConverter(
            fromFirestore: (snapshot, _) => Book.fromMap(snapshot.data()!),
            toFirestore: (Book book, _) => book.toMap())
        .doc(idBook)
        .delete();
  }

  void updateBook(String idBook, Book book) {
    FirebaseFirestore.instance
        .collection("books")
        .withConverter(
            fromFirestore: (snapshot, _) => Book.fromMap(snapshot.data()!),
            toFirestore: (Book book, _) => book.toMap())
        .doc(idBook)
        .update(book.toMap());
  }

  @override
  void onClose() {
    // TODO: implement onClose
    listen.cancel();
    super.onClose();
  }
}
