import 'dart:convert';

import 'rating.dart';

class Product {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory Product.fromMap(Map<String, dynamic> data) => Product(
        id: data['id'] as int?,
        title: data['title'] as String?,
        price: double.tryParse(data['price'] != null
            ? data['price'].toString().replaceAll(' ', '')
            : '0'),
        description: data['description'] as String?,
        category: data['category'] as String?,
        image: data['image'] as String?,
        rating: data['rating'] == null
            ? null
            : Rating.fromMap(data['rating'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'rating': rating?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Product].
  factory Product.fromJson(String data) {
    return Product.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Product] to a JSON string.
  String toJson() => json.encode(toMap());
}
