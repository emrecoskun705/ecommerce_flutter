import 'package:ecommerce_flutter/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/account_page.dart';
import 'components/authentication_page.dart';

//This is the screen which determines page for account screen
// if user is logged in then it will show us account detail page
// otherwise it shows authentication(login, register) page
class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Provider.of<UserProvider>(context).isLoggedIn;

    return isLoggedIn ? AccountPage() : AuthenticationPage();
  }
}
