import 'package:ecommerce_flutter/providers/UserProvider.dart';
import 'package:ecommerce_flutter/providers/persistent_tab_provider.dart';
import 'package:ecommerce_flutter/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        GestureDetector(
          onTap: _login,
          child: SvgPicture.asset(
            'assets/svg/google.svg',
            semanticsLabel: 'Google Sign In',
            height: getProportionateScreenHeight(50),
          ),
        ),
      ],
    );
  }
}
