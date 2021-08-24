import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_flutter/models/cart/order.dart';
import 'package:ecommerce_flutter/models/cart/order_product.dart';
import 'package:ecommerce_flutter/models/minimal_product.dart';
import 'package:ecommerce_flutter/services/product/minimal_product_api.dart';
import 'package:ecommerce_flutter/utils/user_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class OrderApi {
  Future<Order> fetchOrder() async {
    var token = await UserTokenSecureStorage.getToken();
    var url = Uri.parse('$kServerApiURL/order-user/');
    http.Response response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Token ${token.toString()}'
    });

    List<OrderProduct> productList = [];
    print(response.statusCode);
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      for (var orderProduct in data['items']) {
        MinimalProduct minimalProduct = await MinimalProductApi()
            .fetchMinimalProduct(orderProduct['product'].toInt());
        int quantity = orderProduct['quantity'].toInt();
        productList
            .add(OrderProduct(product: minimalProduct, quantity: quantity));
      }
    }

    return Order(productList: productList);
  }
}
