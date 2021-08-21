import 'package:ecommerce_flutter/models/product.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  Product? product;

  ProductProvider();
  void setProduct(Product product) {
    this.product = product;
    notifyListeners();
  }
}
