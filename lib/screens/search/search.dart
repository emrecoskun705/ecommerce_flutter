import 'package:ecommerce_flutter/screens/components/search_bar.dart';
import 'package:ecommerce_flutter/size_config.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_flutter/constants.dart';

class SearchScreen extends StatelessWidget {
  static TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Hero(
              tag: kSearchBarTag,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(10),
                    horizontal: getProportionateScreenWidth(20)),
                child: SearchBar(
                  enabled: true,
                  controller: _controller,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
