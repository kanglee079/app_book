import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static FirebaseFirestore get firestore => _firestore;

  Future<void> addUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      DocumentReference docRef = _firestore.collection('users').doc(user.id);
      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        await docRef.update(user.toMap());
      } else {
        await docRef.set(user.toMap());
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserOnlineStatus(String userId, bool isOnline) async {
    try {
      DocumentReference docRef = _firestore.collection('users').doc(userId);

      await docRef.update({'isOnline': isOnline});
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getUser(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // // kiểm tra id hiện tại của category tới đâu để tăng dần
  // static Future<int> getNextCategoryId() async {
  //   final counterRef =
  //       FirebaseFirestore.instance.collection('counters').doc('category');
  //   final snapshot = await counterRef.get();

  //   if (!snapshot.exists) {
  //     await counterRef.set({'currentId': 1});
  //     return 1;
  //   } else {
  //     int currentId = snapshot.data()!['currentId'];
  //     await counterRef.update({'currentId': FieldValue.increment(1)});
  //     return currentId + 1;
  //   }
  // }

  // // thêm category
  // static Future<void> addCategory(Category category) async {
  //   // int id = await getNextCategoryId();
  //   // category.id = id.toString();
  //   // await FirebaseFirestore.instance
  //   //     .collection('categories')
  //   //     .doc(category.id)
  //   //     .set(category.toMap());

  //   FirebaseFirestore.instance
  //       .collection("categories")
  //       .withConverter(
  //           fromFirestore: (snapshot, _) => Category.fromMap(snapshot.data()!),
  //           toFirestore: (Category cate, _) => cate.toMap())
  //       .add(category);
  // }

  // // lấy toàn bộ category
  // static Stream<List<Category>> getAllCategories() {
  //   return FirebaseFirestore.instance
  //       .collection('categories')
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       return Category.fromMap(doc.data());
  //     }).toList();
  //   });
  // }

  // // lấy category dựa trên id
  // static Future<Category> getCategoryById(String categoryId) async {
  //   DocumentSnapshot doc =
  //       await _firestore.collection('categories').doc(categoryId).get();

  //   if (!doc.exists) {
  //     throw Exception('Category not found');
  //   }

  //   return Category.fromMap(doc.data() as Map<String, dynamic>);
  // }

  // // sửa category
  // static Future<void> updateCategory(Category category) async {
  //   if (category.id == null) {
  //     throw Exception('Category ID is null');
  //   }

  //   await _firestore
  //       .collection('categories')
  //       .doc(category.id)
  //       .update(category.toMap());
  // }

  // // xoá category
  // static Future<void> deleteCategory(String categoryId) async {
  //   await _firestore.collection('categories').doc(categoryId).delete();
  // }

  // // thêm sách
  // static Future<void> addBook(Book book) async {
  //   CollectionReference books = _firestore.collection('books');

  //   final bookExists = await books.doc(book.id).get();
  //   if (bookExists.exists) {
  //     throw Exception('Một sách với tên này đã tồn tại.');
  //   }

  //   await books.doc(book.id).set(book.toMap());
  // }

  // // lấy sách dựa trên category
  // static Stream<List<Book>> getBooksByCategory(String idCategory) {
  //   return _firestore
  //       .collection('books')
  //       .where('idCategory', isEqualTo: idCategory)
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs.map((doc) => Book.fromMap(doc.data())).toList();
  //   });
  // }

  // // lấy sách dựa trên id sách
  // static Future<Book> getBookById(String bookId) async {
  //   DocumentSnapshot doc =
  //       await _firestore.collection('books').doc(bookId).get();

  //   if (!doc.exists) {
  //     throw Exception('Book not found');
  //   }

  //   return Book.fromMap(doc.data() as Map<String, dynamic>);
  // }

  // // lấy toàn bộ sách
  // static Stream<List<Book>> getAllBooks() {
  //   return _firestore.collection('books').snapshots().map((snapshot) {
  //     return snapshot.docs.map((doc) => Book.fromMap(doc.data())).toList();
  //   });
  // }

  // // sửa sách
  // static Future<void> updateBook(Book book) async {
  //   if (book.id.isEmpty) {
  //     throw Exception('Book ID is null or empty');
  //   }
  //   await _firestore.collection('books').doc(book.id).update(book.toMap());
  // }

  // // xoá sách
  // static Future<void> deleteBook(String bookId) async {
  //   await _firestore.collection('books').doc(bookId).delete();
  // }
}
