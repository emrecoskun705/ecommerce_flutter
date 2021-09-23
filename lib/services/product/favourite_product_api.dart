import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_flutter/constants.dart';
import 'package:ecommerce_flutter/models/minimal_product.dart';
import 'package:ecommerce_flutter/utils/user_secure_storage.dart';
import 'package:http/http.dart' as http;

enum FavouriteProductAction { add, remove }

class FavouriteProductApi {
  Future<List<MinimalProduct>> fetchFavouriteProductList() async {
    var token = await UserTokenSecureStorage.getToken();
    var url = Uri.parse('$kServerApiURL/favourite-product-list/');
    http.Response response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Token ${token.toString()}',
      },
    );

    List<MinimalProduct> productList = [];
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      for (var p in data) {
        dynamic responseFavouriteProduct =
            await FavouriteProductApi().fetchFavouriteProduct(p['id']);
        late bool isFavourite;
        if (responseFavouriteProduct) {
          isFavourite = true;
        } else {
          isFavourite = false;
        }

        MinimalProduct minimalProduct = MinimalProduct(
          id: p['id'],
          title: p['title'],
          image: p['image'],
          price: p['price'],
          discountPrice:
              p['discount_price'] == null ? 0.0 : p['discount_price'],
        );
        minimalProduct.isFavourite = isFavourite;

        productList.add(minimalProduct);
      }
    }

    return productList;
  }

  Future<bool> fetchFavouriteProduct(int productId) async {
    var token = await UserTokenSecureStorage.getToken();
    var url = Uri.parse(
        '$kServerApiURL/favourite-product-list/${productId.toString()}/');

    http.Response response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Token ${token.toString()}'
    });
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
