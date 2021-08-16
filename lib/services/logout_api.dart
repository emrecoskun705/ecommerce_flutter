import 'package:ecommerce_flutter/constants.dart';
import 'package:http/http.dart' as http;

// Logout api is used for changing User token
// when we call this api user token changes

class LogoutApi {
  final String? token;

  LogoutApi({required this.token});

  Future<dynamic> fetchData() async {
    var url = Uri.parse('$kServerAuthApiURL/logout/');
    http.Response response = await http.post(
      url,
      body: {'token': 'Token $token'},
    );
    return response;
  }
}
