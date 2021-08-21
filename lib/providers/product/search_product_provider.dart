import 'package:ecommerce_flutter/models/minimal_product.dart';
import 'package:ecommerce_flutter/services/search_api.dart';
import 'package:flutter/material.dart';

class SearchProductProvider extends ChangeNotifier {
  bool isLoading = false;
  int page = 1;
  List<MinimalProduct> productList = [];
  int length = 0;

  Future fetchData(String query) async {
    setIsLoading(true);
    var productList = await SearchApi().fetchSearchProduct(query, page);
    // print(productList);
    updateLength(this.productList.length + productList.length);
    addProducts(productList);

    setIsLoading(false);
    incrementPage();
  }

  void addProducts(List<MinimalProduct> productList) {
    this.productList.addAll(productList);
    notifyListeners();
  }

  void updateLength(int value) {
    length = value;
    notifyListeners();
  }

  void incrementPage() {
    page++;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
