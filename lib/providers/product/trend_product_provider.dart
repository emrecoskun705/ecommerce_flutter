import 'dart:convert';
import 'package:ecommerce_flutter/models/minimal_product.dart';
import 'package:ecommerce_flutter/services/product/trend_product_api.dart';
import 'package:flutter/cupertino.dart';

class TrendProductProvider with ChangeNotifier {
  String _errorMessage = '';
  bool _loading = true;
  bool _error = false;
  List<MinimalProduct> productList = [];

  Future fetchTrendProducts() async {
    setLoading(true);
    await TrendProductApi().fetchData().then((response) {
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        List<MinimalProduct> tempProductList = [];
        for (var product in data) {
          tempProductList.add(MinimalProduct(
            id: product['id'],
            title: product['title'],
            image: product['image'],
            price: product['price'],
            discountPrice: product['discount_price'] != null
                ? product['discount_price']
                : 0.0,
          ));
        }
        setProductList(tempProductList);
      }
    });
    setLoading(false);
  }

  void setProductList(List<MinimalProduct> productList) {
    this.productList = productList;
    notifyListeners();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
