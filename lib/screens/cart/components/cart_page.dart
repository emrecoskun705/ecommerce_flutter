import 'package:ecommerce_flutter/providers/order_provider.dart';
import 'package:ecommerce_flutter/screens/cart/components/address_select_screen.dart';
import 'package:ecommerce_flutter/screens/components/rounded_button.dart';
import 'package:ecommerce_flutter/size_config.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'order_products.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: OrderProducts(),
      bottomNavigationBar: context.watch<OrderProvider>().isLoading
          ? SizedBox()
          : buildBottomNavbar(context),
    );
  }

  Material buildBottomNavbar(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(),
        child: SizedBox(
          height: 100,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total',
                      style:
                          TextStyle(fontSize: getProportionateScreenHeight(20)),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${context.read<OrderProvider>().getTotal()}\$',
                      style:
                          TextStyle(fontSize: getProportionateScreenHeight(20)),
                    ),
                  ],
                ),
                RoundedButton(
                  colour: Colors.orange,
                  title: 'Buy',
                  onPressed: () {
                    pushNewScreen(context, screen: AddressSelectScreen());
                  },
                )
              ],
            ),
          ),
        ),
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
            Text(
              "3 items",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
