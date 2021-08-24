import 'package:ecommerce_flutter/models/minimal_product.dart';

class OrderProduct {
  final MinimalProduct product;
  int quantity;

  OrderProduct({required this.product, required this.quantity});
}
