import 'package:flutter/foundation.dart';

@immutable
class Product {
  final int id;
  final String title;
  final String? price;
  final String? category;
  final String? image;
  final String? description;
  final String? permalink;

  const Product({
    required this.id,
    required this.title,
    this.price,
    this.category,
    this.image,
    this.description,
    this.permalink,
  });

  factory Product.fromWooJson(Map<String, dynamic> json) {
    final images = (json['images'] as List?) ?? const [];
    final cats = (json['categories'] as List?) ?? const [];
    String? str(dynamic v) => (v is String && v.isNotEmpty) ? v : null;

    return Product(
      id: json['id'] as int,
      title: json['name'] as String? ?? 'Товар',
      price:
          str(json['price']) ??
          str(json['regular_price']) ??
          str(json['sale_price']),
      category: cats.isNotEmpty ? (cats.first['slug'] as String?) : null,
      image: images.isNotEmpty ? (images.first['src'] as String?) : null,
      description: str(json['short_description']) ?? str(json['description']),
      permalink: str(json['permalink']),
    );
  }
}
