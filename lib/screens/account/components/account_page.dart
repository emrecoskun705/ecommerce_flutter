import 'package:ecommerce_flutter/models/account_choice.dart';
import 'package:ecommerce_flutter/providers/UserProvider.dart';
import 'package:ecommerce_flutter/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

//user detail page
class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    List<AccountChoice> choices = [
      AccountChoice(
          name: 'My Orders', icon: Icons.shopping_cart, function: () {}),
      AccountChoice(
          name: 'My Favourites', icon: FontAwesomeIcons.heart, function: () {}),
      AccountChoice(
          name: 'My Refunds', icon: Icons.arrow_back, function: () {}),
      AccountChoice(
          name: 'Account Information',
          icon: FontAwesomeIcons.addressCard,
          function: () {}),
      AccountChoice(
          name: 'Address Information',
          icon: FontAwesomeIcons.city,
          function: () {}),
      AccountChoice(
          name: 'Logout',
          icon: Icons.close,
          function: () async {
            await Provider.of<UserProvider>(context, listen: false).logout();
          }),
    ];

    return Scaffold(
      appBar: buildAppBar(),
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<UserProvider>(context).isLoading,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.grey.withOpacity(0.2),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(10), horizontal: 10),
                child: Text(
                  'Account',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: getProportionateScreenHeight(30),
                  ),
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: choices.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: ListTile(
                      leading: Icon(choices[index].icon),
                      title: Text(choices[index].name),
                    ),
                    onTap: choices[index].function,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFFFFAFAFA),
      centerTitle: true,
      title: Text(
        'Emre\'s E-Commerce',
        style: TextStyle(
          color: Color(0xFF8ECAE6),
        ),
      ),
    );
  }
}
