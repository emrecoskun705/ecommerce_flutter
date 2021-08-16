import 'package:http/http.dart' as http;

import '../constants.dart';

class RegisterApi {
  final String email;
  final String password1;
  final String password2;

  RegisterApi(
      {required this.email, required this.password1, required this.password2});

  Future<dynamic> fetchData() async {
    var url = Uri.parse('$kServerAuthApiURL/registration/');
    http.Response response = await http.post(
      url,
      body: {
        'email': email,
        'password1': password1,
        'password2': password2,
      },
    );

    return response;
  }
}
