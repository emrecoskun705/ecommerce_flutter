import 'package:ecommerce_flutter/providers/persistent_tab_provider.dart';
import 'package:ecommerce_flutter/screens/components/rounded_button.dart';
import 'package:ecommerce_flutter/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmptyCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.shopping_cart,
            size: getProportionateScreenHeight(300),
            color: Colors.grey,
          ),
          Center(
              child: Text(
            'Your cart is empty',
            style: TextStyle(fontSize: getProportionateScreenHeight(30)),
          )),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(30),
                horizontal: getProportionateScreenWidth(50)),
            child: RoundedButton(
              primaryColor: Colors.white,
              title: 'Continue Shopping',
              onPressed: () {
                Provider.of<PersistentTabProvider>(context, listen: false)
                    .changeTab(0);
              },
              bgColor: Colors.lightBlueAccent,
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Color(0xFFFAFAFA),
      elevation: 0,
      title: Center(
        child: Column(
          children: [
            Text(
              "Your Cart",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
