import 'package:ecommerce_flutter/providers/persistent_tab_provider.dart';
import 'package:ecommerce_flutter/screens/account/account_screen.dart';
import 'package:ecommerce_flutter/screens/cart/cart_screen.dart';
import 'package:ecommerce_flutter/screens/category/category_screen.dart';
import 'package:ecommerce_flutter/screens/home/home_screen.dart';
import 'package:ecommerce_flutter/screens/search/search.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../size_config.dart';
import 'cart/components/cart_page.dart';

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
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.category),
        title: ("Categories"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.shopping_cart),
          title: ("Cart"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
          onPressed: (_) {
            pushNewScreen(
              context,
              screen: CartPage(),
              pageTransitionAnimation: PageTransitionAnimation.slideUp,
              withNavBar: false,
            );
          }),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.account_circle),
          title: ("Account"),
          activeColorPrimary: Color(0xFFFFB703),
          inactiveColorPrimary: Colors.grey,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
              initialRoute: '/',
              routes: {'/register': (context) => Container()})),
    ];
  }

  @override
  void initState() {
    super.initState();
    Provider.of<PersistentTabProvider>(context, listen: false)
        .controller
        .addListener(() {
      int index = Provider.of<PersistentTabProvider>(context, listen: false)
          .controller
          .index;
      Provider.of<PersistentTabProvider>(context, listen: false)
          .isVisibleAppBar(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    PersistentTabController _controller =
        Provider.of<PersistentTabProvider>(context).controller;
    return Scaffold(
      appBar: Provider.of<PersistentTabProvider>(context).isVisibleAppBarBool
          ? AppBar(
              title: Center(
                child: Text(
                  'Emre\'s E-Commerce',
                  style: TextStyle(
                    color: Color(0xFF8ECAE6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  padding: EdgeInsets.only(right: 10.0),
                  onPressed: () async {
                    showSearch(context: context, delegate: SearchBar());
                  },
                  icon: Icon(
                    Icons.search,
                    size: 40.0,
                    color: Colors.grey,
                  ),
                ),
              ],
              elevation: 10,
              backgroundColor: Colors.white,
            )
          : null,
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
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}
