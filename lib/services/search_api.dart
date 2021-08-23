import 'package:ecommerce_flutter/models/minimal_product.dart';
import 'dart:convert';
import '../constants.dart';
import 'package:http/http.dart' as http;

class SearchApi {
  Future<List<MinimalProduct>> fetchSearchProduct(
      String query, int page) async {
    var url = Uri.parse('$kServerApiURL/search-product/');
    url =
        url.replace(queryParameters: {'title': query, 'page': page.toString()});
    http.Response response = await http.get(url);

    List<MinimalProduct> productList = [];
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);

      for (dynamic result in data['results']) {
        productList.add(MinimalProduct(
            id: result['id'],
            title: result['title'],
            image: result['image'],
            price: result['price'],
            discountPrice: result['discount_price'] == null
                ? 0
                : result['discount_price']));
      }
    }
    return productList;
  }
}
