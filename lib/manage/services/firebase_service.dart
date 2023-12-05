import 'package:app_book/models/book_model.dart';
import 'package:app_book/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static FirebaseFirestore get firestore => _firestore;

  static Future<int> getNextCategoryId() async {
    final counterRef =
        FirebaseFirestore.instance.collection('counters').doc('category');
    final snapshot = await counterRef.get();

    if (!snapshot.exists) {
      await counterRef.set({'currentId': 1});
      return 1;
    } else {
      int currentId = snapshot.data()!['currentId'];
      await counterRef.update({'currentId': FieldValue.increment(1)});
      return currentId + 1;
    }
  }

  static Future<void> addCategory(Category category) async {
    int id = await getNextCategoryId();
    category.id = id.toString();
    await FirebaseFirestore.instance
        .collection('categories')
        .doc(category.id)
        .set(category.toMap());
  }

  static Stream<List<Category>> getAllCategories() {
    return FirebaseFirestore.instance
        .collection('categories')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Category.fromMap(doc.data());
      }).toList();
    });
  }

  static Future<void> addBookToCategory(String categoryName, Book book) async {
    if (categoryName.isEmpty) {
      print("Tên thể loại không thể rỗng");
    }
    await _firestore
        .collection('Manage')
        .doc('categories')
        .collection(categoryName)
        .doc(book.id)
        .set(book.toMap());
  }

  static Stream<List<Book>> getBooksFromCategory(String categoryName) {
    return _firestore
        .collection('Manage')
        .doc('categories')
        .collection(categoryName)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Book.fromMap(doc.data())).toList());
  }

  static Future<List<Book>> getAllBooks() async {
    var categoriesSnapshot =
        await _firestore.collection('Manage').doc('categories').get();
    if (!categoriesSnapshot.exists) return [];

    List<dynamic> categories = categoriesSnapshot.data()!['categoryList'];
    var allBooksFutures =
        categories.map((category) => getBooksFromCategory(category).first);

    var allBooksLists = await Future.wait(allBooksFutures);
    return allBooksLists.expand((books) => books).toList();
  }
}