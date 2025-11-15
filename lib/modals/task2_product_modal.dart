import 'dart:convert';

Task2ProductModal task2ProductModalFromJson(String str) =>
    Task2ProductModal.fromJson(json.decode(str));

String task2ProductModalToJson(Task2ProductModal data) =>
    json.encode(data.toJson());

class Task2ProductModal {
  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? category;
  final String? image;
  final Rating? rating;

  Task2ProductModal({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory Task2ProductModal.fromJson(Map<String, dynamic> json) =>
      Task2ProductModal(
        id: json['id'],
        title: json['title'],
        price: json['price']?.toDouble(),
        description: json['description'],
        category: json['category'],
        image: json['image'],
        rating: json['rating'] == null ? null : Rating.fromJson(json['rating']),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'description': description,
    'category': category,
    'image': image,
    'rating': rating?.toJson(),
  };
}

class Rating {
  final double? rate;
  final int? count;

  Rating({this.rate, this.count});

  factory Rating.fromJson(Map<String, dynamic> json) =>
      Rating(rate: json['rate']?.toDouble(), count: json['count']);

  Map<String, dynamic> toJson() => {'rate': rate, 'count': count};
}
