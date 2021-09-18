import 'package:google_sign_in/google_sign_in.dart';
import 'package:ecommerce_flutter/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleSignInApi {
  static final googleSignIn = GoogleSignIn();

  static Future<String?> getToken(String accessToken) async {
    var url = Uri.parse('$kServerAuthApiURL/google/');
    http.Response response = await http.post(
      url,
      body: {
        'access_token': accessToken,
      },
    );

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);

      return data['key'];
    }

    return null;
  }

  static Future<String?> handleSignIn() async {
    try {
      var user = await googleSignIn.signIn();
      var auth = await user!.authentication;
      return auth.accessToken;
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<void> handleSignOut() => googleSignIn.disconnect();
}
