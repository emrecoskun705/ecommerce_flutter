import 'package:ecommerce_flutter/models/category.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'dart:convert';

class CategoryApi {
  Future<List<Category>> fetchCategories(String slug) async {
    var url = Uri.parse('$kServerApiURL/category-list/');
    url = url.replace(queryParameters: {'slug': slug});
    http.Response response = await http.get(url);

    List<Category> categoryList = [];
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      for (dynamic category in data) {
        categoryList.add(Category(
            id: category['id'].toInt(),
            name: category['name'],
            slug: category['slug']));
      }
    }

    return categoryList;
  }
}
