import 'package:ecommerce_flutter/constants.dart';
import 'package:http/http.dart' as http;

class TrendProductApi {
  //it fetches the data from given address using email and password
  Future<dynamic> fetchData() async {
    var url = Uri.parse('$kServerApiURL/trend-product-list/');
    http.Response response = await http.get(url);
    return response;
  }
}
