import 'dart:collection';
import 'dart:convert';
import 'package:ecommerce_flutter/models/product.dart';
import 'package:ecommerce_flutter/services/favourite_product_api.dart';
import 'package:ecommerce_flutter/services/trend_product_api.dart';
import 'package:flutter/cupertino.dart';

class TrendProductProvider with ChangeNotifier {
  String _errorMessage = '';
  bool _loading = false;
  bool _error = false;
  List<Product> productList = [];

  Future fetchTrendProducts() async {
    await TrendProductApi().fetchData().then((response) {
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        for (var product in data) {
          addProduct(Product(
              id: product['id'],
              title: product['title'],
              description: product['description'],
              image: product['image'],
              price: product['price'],
              discountPrice: product['discountPrice'] != null
                  ? product['discountPrice']
                  : 0.0,
              stock: product['stock']));
        }
      }
    });
  }

  void addProduct(Product product) {
    productList.add(product);
    notifyListeners();
  }
}
