import 'package:ecommerce_flutter/providers/UserProvider.dart';
import 'package:ecommerce_flutter/providers/persistent_tab_provider.dart';
import 'package:ecommerce_flutter/services/google_signin_api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

import 'package:provider/provider.dart';

class GoogleLogin extends StatefulWidget {
  @override
  _GoogleLoginState createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  void _login() {
    Provider.of<UserProvider>(context, listen: false)
        .fetchGoogleUser()
        .then((value) {
      if (value)
        Provider.of<PersistentTabProvider>(context, listen: false).changeTab(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: _login,
          icon: Icon(FontAwesomeIcons.google),
        ),
      ],
    );
  }
}
