import 'package:ecommerce_flutter/services/order_api.dart';
import 'package:flutter/cupertino.dart';

class StripeProvider with ChangeNotifier {
  String? stripeURL;
  bool isLoading = true;

  OrderApi _orderApi = OrderApi();

  Future fetchStripeURL() async {
    setIsLoading(true);
    setStripeURL(await _orderApi.fetchStripeURL());
    setIsLoading(false);
  }

  void setStripeURL(String url) {
    this.stripeURL = url;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    this.isLoading = value;
    notifyListeners();
  }
}
