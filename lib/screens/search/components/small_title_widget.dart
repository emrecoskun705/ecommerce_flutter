import 'package:flutter/cupertino.dart';
import 'package:ecommerce_flutter/size_config.dart';

class SmallTitle extends StatelessWidget {
  final String text;

  SmallTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: getProportionateScreenWidth(15),
          bottom: getProportionateScreenHeight(5)),
      child: Text(
        text,
        style: TextStyle(
          fontSize: getProportionateScreenHeight(25),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
