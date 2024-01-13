import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Book {
  String id;
  String? bookName;
  String? authorName;
  String? idCategory;
  String? desc;
  String? photoUrl;
  String? pdfUrl;
  bool isFeatured;
  Book({
    required this.id,
    this.bookName,
    this.authorName,
    this.idCategory,
    this.desc,
    this.photoUrl,
    this.pdfUrl,
    this.isFeatured = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bookName': bookName,
      'authorName': authorName,
      'idCategory': idCategory,
      'desc': desc,
      'photoUrl': photoUrl,
      'pdfUrl': pdfUrl,
      'isFeatured': isFeatured,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as String,
      bookName: map['bookName'] != null ? map['bookName'] as String : null,
      authorName:
          map['authorName'] != null ? map['authorName'] as String : null,
      idCategory:
          map['idCategory'] != null ? map['idCategory'] as String : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
      pdfUrl: map['pdfUrl'] != null ? map['pdfUrl'] as String : null,
      isFeatured: map['isFeatured'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) =>
      Book.fromMap(json.decode(source) as Map<String, dynamic>);
}
