import 'package:ecommerce_flutter/models/cart/address.dart';
import 'package:ecommerce_flutter/models/cart/order.dart';
import 'package:ecommerce_flutter/models/cart/order_product.dart';
import 'package:ecommerce_flutter/models/minimal_product.dart';
import 'package:ecommerce_flutter/services/order_api.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider extends ChangeNotifier {
  Order order = Order(productList: []);
  bool isLoading = true;
  bool isEmpty = true;

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
      for (var orderProduct in order.productList) {
        if (orderProduct.id == orderProductId) {
          order.productList[i].quantity = newQuantity;
          notifyListeners();
          break;
        }
        i++;
      }
    }
    setIsLoading(false);
    return success;
  }

  Future<bool> deleteOrderProduct(OrderProduct orderProduct) async {
    setIsLoading(true);
    bool success = await orderApi.deleteOrderProduct(orderProduct.id);
    if (success) {
      removeOrderProduct(orderProduct);
    }
    setIsLoading(false);
    return success;
  }

  Future<bool> postOrderProduct(MinimalProduct product) async {
    setIsLoading(true);
    var orderProduct = await orderApi.addProduct(product);
    if (orderProduct != null) {
      addOrderProduct(orderProduct);
      setIsLoading(false);
      return true;
    } else {
      setIsLoading(false);
      return false;
    }
  }

  void setShippingAddress(Address address) {
    order.shippingAddress = address;
    notifyListeners();
  }

  void setBillingAddress(Address address) {
    order.billingAddress = address;
    notifyListeners();
  }

  void removeOrderProduct(OrderProduct orderProduct) {
    order.productList.remove(orderProduct);
    notifyListeners();
  }

  void addOrderProduct(OrderProduct orderProduct) {
    order.productList.add(orderProduct);
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
    for (var orderProduct in order.productList) {
      if (orderProduct.product.discountPrice == 0.0) {
        total += orderProduct.quantity * orderProduct.product.price;
      } else {
        total += orderProduct.quantity * orderProduct.product.discountPrice;
      }
    }

    return total;
  }
}
