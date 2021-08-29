import 'package:ecommerce_flutter/providers/UserProvider.dart';
import 'package:ecommerce_flutter/providers/carousel_provider.dart';
import 'package:ecommerce_flutter/screens/home/components/home_carousel.dart';
import 'package:ecommerce_flutter/screens/search/search.dart';
import 'package:ecommerce_flutter/screens/home/components/trend_products.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart' show GFCarousel;
import 'package:provider/provider.dart';

import '../../size_config.dart';

class HomeScreen extends StatefulWidget {
  static const id = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselProvider _carouselProvider = CarouselProvider();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // check if user is logged in or not
    Provider.of<UserProvider>(context, listen: false).checkIsLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    var _spacer = SizedBox(height: getProportionateScreenHeight(20.0));
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        children: [
          _spacer,
          HomeCarousel(),
          _spacer,
          TrendProducts(),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }
}
