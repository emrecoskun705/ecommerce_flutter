import 'package:ecommerce_flutter/models/product.dart';
import 'package:ecommerce_flutter/services/product/favourite_product_api.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_flutter/constants.dart';
import 'dart:convert';

class ProductDetailApi {
  // fetch one product which has id=productId
  Future<Product> fetchData(int productId) async {
    var url = Uri.parse('$kServerApiURL/product-detail/');
    url = url.replace(queryParameters: {'productId': productId.toString()});
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);

      // add main screen to images list with other images data['images']
      List<dynamic> images = [data['image']];
      if (data['images'].length != 0) {
        for (var img in data['images']) {
          images.add(img['image']);
        }
      }
      int i = 0;
      for (var img in images) {
        if (!img.toString().contains(kServerApiURL)) {
          images[i] = '$kServerURL$img';
        }
        i++;
      }

      // fetch favourite product response. If it is true, product is favourite otherwise not
      dynamic responseFavouriteProduct =
          await FavouriteProductApi().fetchFavouriteProduct(productId);
      print(responseFavouriteProduct);
      late bool isFavourite;
      if (responseFavouriteProduct) {
        isFavourite = true;
      } else {
        isFavourite = false;
      }

      return Product(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        images: images,
        price: data['price'],
        discountPrice:
            data['discount_price'] == null ? 0.0 : data['discount_price'],
        stock: data['stock'],
        isFavourite: isFavourite,
      );
    } else {
      throw Exception(['There is no product']);
    }
  }
}
