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
}
