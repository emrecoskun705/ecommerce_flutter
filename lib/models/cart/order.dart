import 'package:ecommerce_flutter/models/cart/address.dart';
import 'package:ecommerce_flutter/models/cart/order_product.dart';

class Order {
  List<OrderProduct> productList;
  late Address shippingAddress;
  late Address billingAddress;

  Order({required this.productList});
}
