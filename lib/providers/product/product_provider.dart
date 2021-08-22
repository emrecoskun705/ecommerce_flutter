import 'package:ecommerce_flutter/models/product.dart';
import 'package:ecommerce_flutter/services/product/favourite_product_api.dart';
import 'package:ecommerce_flutter/services/product/product_detail_api.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  Product? product;
  bool isLoading = true;

  Future fetchProduct(int productId) async {
    setIsLoading(true);
    var product = await ProductDetailApi().fetchData(productId);
    setProduct(product);
    setIsLoading(false);
  }

  Future postFavourite() async {
    await FavouriteProductApi().postData(
        product!.id,
        product!.isFavourite
            ? FavouriteProductAction.remove
            : FavouriteProductAction.add);
    setFavourite(!product!.isFavourite);
  }

  void setIsLoading(bool value) {
    this.isLoading = value;
    notifyListeners();
  }

  void setProduct(Product product) {
    this.product = product;
    notifyListeners();
  }

  void setFavourite(bool value) {
    product!.isFavourite = value;
    notifyListeners();
  }
}
