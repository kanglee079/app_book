class SliderImage {
  String id;
  String imageUrl;
  String? title;
  String? description;

  SliderImage({
    required this.id,
    required this.imageUrl,
    this.title,
    this.description,
  });

  factory SliderImage.fromMap(Map<String, dynamic> data) {
    return SliderImage(
      id: data['id'],
      imageUrl: data['imageUrl'],
      title: data['title'],
      description: data['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
    };
  }
}
