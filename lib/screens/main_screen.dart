import 'package:ecommerce_flutter/providers/UserProvider.dart';
import 'package:ecommerce_flutter/providers/order_provider.dart';
import 'package:ecommerce_flutter/providers/persistent_tab_provider.dart';
import 'package:ecommerce_flutter/screens/account/account_screen.dart';
import 'package:ecommerce_flutter/screens/cart/cart_screen.dart';
import 'package:ecommerce_flutter/screens/category/category_screen.dart';
import 'package:ecommerce_flutter/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../size_config.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    HomeScreen(),
    CategoryScreen(
      slug: 'root',
      showAll: false,
    ),
    CartScreen(),
    AccountScreen(),
  ];

  List<PersistentBottomNavBarItem> _navbarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(initialRoute: '/'),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.category),
        title: ("Categories"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(initialRoute: '/'),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart),
        title: ("Cart"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        onPressed: (_) {
          // if user is not logged in no need to check if there is an order
          if (context.read<UserProvider>().isLoggedIn) {
            Provider.of<OrderProvider>(context, listen: false).fetchOrder();
          }
          Provider.of<PersistentTabProvider>(context, listen: false)
              .changeTab(2);
        },
      ),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.account_circle),
          title: ("Account"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
              initialRoute: '/',
              routes: {'/register': (context) => Container()})),
    ];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    PersistentTabController _controller =
        Provider.of<PersistentTabProvider>(context).controller;
    return Scaffold(
      body: buildPersistentTabView(context, _controller),
    );
  }

  PersistentTabView buildPersistentTabView(
      BuildContext context, PersistentTabController controller) {
    return PersistentTabView(
      context,
      controller: controller,
      screens: screens,
      items: _navbarItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Color(0xFF8ECAE6),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),

      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}
