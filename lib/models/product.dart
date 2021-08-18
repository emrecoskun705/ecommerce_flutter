import 'package:flutter/cupertino.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final String image;
  final double price;
  final double discountPrice; // if it is -1.0 there is no discount
  final int stock;
  bool isFavourite = false;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.discountPrice,
    required this.stock,
  });
}
