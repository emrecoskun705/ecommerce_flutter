import 'package:ecommerce_flutter/models/product.dart';
import 'package:ecommerce_flutter/providers/UserProvider.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_flutter/constants.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

class ProductDetailApi {
  // fetch one product which has id=productId
  static Future<Product> fetchData(int productId) async {
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

      return Product(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        images: images,
        price: data['price'],
        discountPrice:
            data['discount_price'] == null ? 0.0 : data['discount_price'],
        stock: data['stock'],
      );
    } else {
      throw Exception(['There is no product']);
    }
  }
}
