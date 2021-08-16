import 'package:ecommerce_flutter/screens/components/home_carousel.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const id = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int counter = 0;
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeCarousel(),
      ],
    );
  }
}
