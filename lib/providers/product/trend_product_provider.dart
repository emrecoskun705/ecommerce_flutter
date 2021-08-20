import 'dart:convert';
import 'package:ecommerce_flutter/models/minimal_product.dart';
import 'package:ecommerce_flutter/services/product/trend_product_api.dart';
import 'package:flutter/cupertino.dart';

class TrendProductProvider with ChangeNotifier {
  String _errorMessage = '';
  bool _loading = false;
  bool _error = false;
  List<MinimalProduct> productList = [];

  Future fetchTrendProducts() async {
    await TrendProductApi().fetchData().then((response) {
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        for (var product in data) {
          addProduct(MinimalProduct(
            id: product['id'],
            title: product['title'],
            image: product['image'],
            price: product['price'],
            discountPrice: product['discountPrice'] != null
                ? product['discountPrice']
                : 0.0,
          ));
        }
      }
    });
  }

  void addProduct(MinimalProduct product) {
    productList.add(product);
    notifyListeners();
  }
}
