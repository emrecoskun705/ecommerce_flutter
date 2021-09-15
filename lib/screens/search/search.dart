import 'package:ecommerce_flutter/screens/components/search_bar.dart';
import 'package:ecommerce_flutter/size_config.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  static TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10),
                  horizontal: getProportionateScreenWidth(15)),
              child: Row(
                children: [
                  Flexible(
                    child: Hero(
                      tag: 'searchBarTag',
                      child: SearchBar(
                        enabled: true,
                        controller: _controller,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
