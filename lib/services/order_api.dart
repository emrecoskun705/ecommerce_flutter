import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_flutter/models/cart/address.dart';
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
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      for (var orderProduct in data['items']) {
        MinimalProduct minimalProduct = await MinimalProductApi()
            .fetchMinimalProduct(orderProduct['product'].toInt());
        int quantity = orderProduct['quantity'].toInt();
        productList.add(OrderProduct(
            id: orderProduct['id'].toInt(),
            product: minimalProduct,
            quantity: quantity));
      }
    }

    return Order(productList: productList);
  }

  Future<bool> changeQuantity(int orderProductId, int quantity) async {
    var token = await UserTokenSecureStorage.getToken();
    var url = Uri.parse('$kServerApiURL/order-product/$orderProductId/');
    http.Response response = await http.put(url, headers: {
      HttpHeaders.authorizationHeader: 'Token ${token.toString()}',
    }, body: {
      'quantity': quantity.toString(),
    });

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> deleteOrderProduct(int orderProductId) async {
    var token = await UserTokenSecureStorage.getToken();
    var url = Uri.parse('$kServerApiURL/order-product/$orderProductId/');
    http.Response response = await http.delete(url, headers: {
      HttpHeaders.authorizationHeader: 'Token ${token.toString()}',
    });

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<OrderProduct?> addProduct(MinimalProduct product) async {
    var token = await UserTokenSecureStorage.getToken();
    var url = Uri.parse('$kServerApiURL/order-product/');
    http.Response response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Token ${token.toString()}',
      },
      body: {
        'productId': product.id.toString(),
      },
    );

    if (response.statusCode == 201) {
      dynamic data = jsonDecode(response.body);
      return OrderProduct(
          id: data['id'].toInt(), product: product, quantity: 1);
    }

    return null;
  }

  Future<List<Address>> getAddresses() async {
    var token = await UserTokenSecureStorage.getToken();
    var url = Uri.parse('$kServerApiURL/address/');

    http.Response response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Token ${token.toString()}',
      },
    );
    List<Address> addressList = [];
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      for (var address in data) {
        addressList.add(Address(
          address['id'],
          address['address_title'],
          address['country'],
          address['province'],
          address['zip'],
          address['detail'],
        ));
      }
    }

    return addressList;
  }

  Future<bool> postAddresses(Address address) async {
    var token = await UserTokenSecureStorage.getToken();
    var url = Uri.parse('$kServerApiURL/address/');
    http.Response response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Token ${token.toString()}',
      },
      body: {
        'id': address.id,
        'address_title': address.addressTitle,
        'country': address.country,
        'province': address.province,
        'zip': address.zip,
        'detail': address.detail,
      },
    );

    if (response.statusCode == 201) {
      return true;
    }

    return false;
  }

  Future<String> fetchStripeURL() async {
    var token = await UserTokenSecureStorage.getToken();
    var url = Uri.parse('$kServerApiURL/stripe/');

    http.Response response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Token ${token.toString()}',
      },
    );
    dynamic data = jsonDecode(response.body);
    return data['url'];
  }

  Future<bool> addAddressToOrder(int addressId) async {
    var token = await UserTokenSecureStorage.getToken();
    var url = Uri.parse('$kServerApiURL/address/');
    http.Response response = await http.put(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Token ${token.toString()}',
      },
      body: {'id': addressId.toString()},
    );

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
