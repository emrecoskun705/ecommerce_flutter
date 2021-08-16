import 'package:ecommerce_flutter/constants.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  final String email;
  final String password;

  LoginApi({required this.email, required this.password});

  //it fetches the data from given address using email and password
  Future<dynamic> fetchData() async {
    var url = Uri.parse('$kServerAuthApiURL/login/');
    http.Response response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );
    return response;
  }
}
