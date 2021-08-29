import 'package:ecommerce_flutter/models/cart/order_product.dart';
import 'package:ecommerce_flutter/services/order_api.dart';
import 'package:flutter/cupertino.dart';

class OrderListProvider with ChangeNotifier {
  List<OrderProduct> orderProductList = [];
  bool isLoading = true;

  Future fetchOrderProductList() async {
    setIsLoading(true);
    setOrderProductList(await OrderApi().fetchOrderProductList());
    setIsLoading(false);
  }

  void setOrderProductList(List<OrderProduct> orderProductList) {
    this.orderProductList = orderProductList;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    this.isLoading = value;
    notifyListeners();
  }
}
