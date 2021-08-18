import 'dart:io';

import 'package:ecommerce_flutter/constants.dart';
import 'package:ecommerce_flutter/utils/user_secure_storage.dart';
import 'package:http/http.dart' as http;

enum FavouriteProductAction { add, remove }

class FavouriteProductApi {
  Future<dynamic> fetchData() async {
    var token = await UserTokenSecureStorage.getToken();
    var url = Uri.parse('$kServerApiURL/favourite-product-list/');
    http.Response response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: token.toString()});
    return response;
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
