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
    loadFeaturedBooks();
    super.onReady();
  }

  void transToReadPdfBook(String pdfUrl, String bookId) {
    Get.toNamed(RouterName.pdfView, arguments: {'url': pdfUrl, 'id': bookId});
  }

  void transToDetailBook(Book book) {
    Get.toNamed(
      RouterName.detailBook,
      arguments: book,
    );
  }

  void transToSearchPage() {
    Get.toNamed(RouterName.search);
  }

  void transToAddBook() {
    Get.toNamed(RouterName.addBook);
  }

  void transToEditBook(String idBook) {
    Get.toNamed(RouterName.editBook, arguments: idBook);
  }

  List<Book> getBooksByCategory(String idCategory) {
    return state.listBook
        .where((book) => book.idCategory == idCategory)
        .toList();
  }

  Future<List<Book>> getFeaturedBooks() async {
    try {
      QuerySnapshot<Book> querySnapshot = await FirebaseFirestore.instance
          .collection('books')
          .where('isFeatured', isEqualTo: true)
          .withConverter<Book>(
            fromFirestore: (snapshot, _) => Book.fromMap(snapshot.data()!),
            toFirestore: (book, _) => book.toMap(),
          )
          .get();

      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loadFeaturedBooks() async {
    try {
      List<Book> books = await getFeaturedBooks();
      state.featuredBooks.assignAll(books);
    } catch (e) {}
  }

  void addBook(
    String? bookName,
    String? authorName,
    String? idCategory,
    String? desc,
    String? photoUrl,
    String? pdfUrl,
    bool isFeatured,
  ) {
    Book data = Book(
      id: generateRandomIdBook(),
      bookName: bookName,
      authorName: authorName,
      idCategory: idCategory,
      desc: desc,
      photoUrl: photoUrl,
      pdfUrl: pdfUrl,
      isFeatured: isFeatured,
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
