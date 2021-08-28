import 'package:ecommerce_flutter/models/minimal_product.dart';
import 'package:ecommerce_flutter/services/product/favourite_product_api.dart';
import 'package:flutter/cupertino.dart';

class FavouriteProvider with ChangeNotifier {
  List<MinimalProduct> productList = [];
  bool isLoading = true;

  Future fetchFavouriteProductList() async {
    setIsLoading(true);
    setProductList(await FavouriteProductApi().fetchFavouriteProductList());
    setIsLoading(false);
  }

  void setProductList(List<MinimalProduct> productList) {
    this.productList = productList;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    this.isLoading = value;
    notifyListeners();
  }
}
