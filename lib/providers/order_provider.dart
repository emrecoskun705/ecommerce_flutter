import 'package:ecommerce_flutter/models/cart/order.dart';
import 'package:ecommerce_flutter/models/cart/order_product.dart';
import 'package:ecommerce_flutter/services/order_api.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider extends ChangeNotifier {
  Order? order;
  bool isLoading = true;

  final OrderApi orderApi = OrderApi();

  Future fetchOrder() async {
    setIsLoading(true);
    Order order = await orderApi.fetchOrder();
    setOrder(order);
    setIsLoading(false);
  }

  Future<bool> changeQuantity(int orderProductId, int newQuantity) async {
    setIsLoading(true);
    bool success = await orderApi.changeQuantity(orderProductId, newQuantity);
    if (success) {
      int i = 0;
      for (var orderProduct in order!.productList) {
        if (orderProduct.id == orderProductId) {
          order!.productList[i].quantity = newQuantity;
          notifyListeners();
          break;
        }
        i++;
      }
    }
    setIsLoading(false);
    return success;
  }

  void removeOrderProduct(int index) {}

  void addOrderProduct(OrderProduct orderProduct) {
    order!.productList.add(orderProduct);
    notifyListeners();
  }

  void setIsLoading(bool value) {
    this.isLoading = value;
    notifyListeners();
  }

  void setOrder(Order order) {
    this.order = order;
    notifyListeners();
  }

  double getTotal() {
    double total = 0;
    for (var orderProduct in order!.productList) {
      if (orderProduct.product.discountPrice == 0.0) {
        total += orderProduct.quantity * orderProduct.product.price;
      } else {
        total += orderProduct.quantity * orderProduct.product.discountPrice;
      }
    }

    return total;
  }
}
