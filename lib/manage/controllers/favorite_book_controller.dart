import 'package:app_book/apps/helper/showToast.dart';
import 'package:app_book/manage/stores/user_store.dart';
import 'package:app_book/models/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../apps/route/route_name.dart';
import '../state/favorite_book.dart';

class FavoriteBookController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final state = FavoriteBookState();
  final idUser = UserStore.to.userInfo.id;

  @override
  void onReady() {
    super.onReady();
    loadFavoriteBooks();
  }

  void transToDetailBook(Book book) {
    Get.toNamed(
      RouterName.detailBook,
      arguments: book,
    );
  }

  bool isBookFavorite(String bookId) {
    return state.listFavoriteBook.any((book) => book.id == bookId);
  }

  void toggleFavoriteBook(Book book) {
    if (isBookFavorite(book.id)) {
      removeFavoriteBookFromFirebase(book.id);
      showToastError("Đã xoá yêu thích sách !");
    } else {
      addFavoriteBookToFirebase(book);
      showToastSuccess("Đã yêu thích sách !");
    }
  }

  Future<void> loadFavoriteBooks() async {
    try {
      var snapshot = await _firestore
          .collection("users")
          .doc(idUser)
          .collection('favorite_books')
          .get();
      var favoriteBooks =
          snapshot.docs.map((doc) => Book.fromMap(doc.data())).toList();
      state.listFavoriteBook.clear();
      state.listFavoriteBook.addAll(favoriteBooks);
    } catch (e) {
      print("Error loading favorite books: $e");
    }
  }

  Future<void> addFavoriteBookToFirebase(Book book) async {
    if (book.id.isNotEmpty && !isBookFavorite(book.id)) {
      await _firestore
          .collection("users")
          .doc(idUser)
          .collection('favorite_books')
          .doc(book.id)
          .set(book.toMap());
      state.listFavoriteBook.add(book);
    } else {
      print("Invalid book data or already in favorites");
    }
  }

  Future<void> removeFavoriteBookFromFirebase(String bookId) async {
    if (isBookFavorite(bookId)) {
      await _firestore
          .collection("users")
          .doc(idUser)
          .collection('favorite_books')
          .doc(bookId)
          .delete();
      state.listFavoriteBook.removeWhere((book) => book.id == bookId);
    } else {
      print("Book not in favorites");
    }
  }
}
