import 'dart:io';

import 'package:ecommerce_flutter/constants.dart';
import 'package:ecommerce_flutter/utils/user_secure_storage.dart';
import 'package:http/http.dart' as http;

enum FavouriteProductAction { add, remove }

class FavouriteProductApi {
  Future<dynamic> fetchFavouriteProductList() async {
    var token = await UserTokenSecureStorage.getToken();
    var url = Uri.parse('$kServerApiURL/favourite-product-list/');
    http.Response response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: token.toString()});
    return response;
  }

  Future<bool> fetchFavouriteProduct(int productId) async {
    var token = await UserTokenSecureStorage.getToken();
    var url = Uri.parse('$kServerApiURL/favourite-product-list/');
    url = url.replace(queryParameters: {'productId': productId.toString()});
    http.Response response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: token.toString()});
    print(response);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // action is either 'add' or 'remove'
  Future<dynamic> postData(int productId, FavouriteProductAction action) async {
    var token = await UserTokenSecureStorage.getToken();
    var url = Uri.parse('$kServerApiURL/favourite-product-list/');
    http.Response response = await http.post(
      url,
      body: {
        'id': productId.toString(),
        // this part handles selection of add or remove if it is none of them it will return null
        'action': action == FavouriteProductAction.add
            ? 'add'
            : action == FavouriteProductAction.remove
                ? 'remove'
                : null,
      },
      headers: {
        HttpHeaders.authorizationHeader: 'Token $token',
      },
    );

    return response;
  }
}
