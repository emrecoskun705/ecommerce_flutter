import 'package:ecommerce_flutter/providers/UserProvider.dart';
import 'package:ecommerce_flutter/providers/order_provider.dart';
import 'package:ecommerce_flutter/providers/persistent_tab_provider.dart';
import 'package:ecommerce_flutter/screens/cart/components/address_select_screen.dart';
import 'package:ecommerce_flutter/screens/cart/components/empty_cart_screen.dart';
import 'package:ecommerce_flutter/screens/components/rounded_button.dart';
import 'package:ecommerce_flutter/size_config.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'components/order_products.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    // if user is not logged in show empty cart
    // if user does not have any items in it's cart, show empty cart
    // if user is logged in and has product in it's car, show cart
    return context.watch<UserProvider>().isLoggedIn
        ? (Provider.of<OrderProvider>(context).order.productList.length == 0
            ? EmptyCartScreen()
            : ModalProgressHUD(
                inAsyncCall: context.watch<OrderProvider>().isLoading,
                child: Scaffold(
                  appBar: buildAppBar(context),
                  body: OrderProducts(),
                  bottomNavigationBar: context.watch<OrderProvider>().isLoading
                      ? SizedBox()
                      : buildBottomNavbar(context),
                ),
              ))
        : EmptyCartScreen();
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
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: getProportionateScreenWidth(50)),
                    child: RoundedButton(
                      bgColor: Colors.lightBlueAccent,
                      primaryColor: Colors.white,
                      title: 'Buy',
                      onPressed: () {
                        if (Provider.of<UserProvider>(context, listen: false)
                            .isLoggedIn) {
                          pushNewScreen(context, screen: AddressSelectScreen());
                        } else {
                          Provider.of<PersistentTabProvider>(context,
                                  listen: false)
                              .changeTab(3);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
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
          ],
        ),
      ),
    );
  }
}
