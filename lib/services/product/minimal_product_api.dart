import 'package:ecommerce_flutter/models/minimal_product.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import 'dart:convert';

class MinimalProductApi {
  Future<MinimalProduct> fetchMinimalProduct(int id) async {
    var url = Uri.parse('$kServerApiURL/minimal-product/');
    url = url.replace(queryParameters: {'id': id.toString()});
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      // first element of the list has our minimal product data
      var p = data[0];

      return MinimalProduct(
        id: p['id'],
        title: p['title'],
        image: p['image'],
        price: p['price'],
        discountPrice: p['discount_price'] == null ? 0.0 : p['discount_price'],
      );
    } else {
      throw 'Network error';
    }
  }
}
