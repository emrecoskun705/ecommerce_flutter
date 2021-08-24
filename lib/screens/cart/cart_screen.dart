import 'package:ecommerce_flutter/screens/cart/components/cart_page.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // SchedulerBinding.instance!.addPersistentFrameCallback((_) {
    //   pushNewScreen(
    //     context,
    //     screen: CartPage(),
    //     pageTransitionAnimation: PageTransitionAnimation.slideUp,
    //     withNavBar: false,
    //   );
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
