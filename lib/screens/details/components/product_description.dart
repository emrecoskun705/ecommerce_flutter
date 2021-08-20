import 'package:ecommerce_flutter/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDescription extends StatelessWidget {
  final double price;
  final double discountPrice;
  final String description;

  ProductDescription(
      {required this.price,
      required this.discountPrice,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFF979797).withOpacity(0.2),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
            vertical: getProportionateScreenHeight(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingBarIndicator(
                  rating: 2.5,
                  itemSize: getProportionateScreenWidth(20),
                  itemBuilder: (context, _) {
                    return Icon(
                      Icons.star,
                      color: Colors.amber,
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    discountPrice != 0.0
                        ? Column(
                            children: [
                              Text(
                                '%${(((price - discountPrice) / price) * 100).toInt()}',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: getProportionateScreenWidth(13),
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '$price\$',
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: getProportionateScreenWidth(15),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                      width: getProportionateScreenWidth(5),
                    ),
                    Text(
                      discountPrice == 0.0 ? '$price\$' : '$discountPrice\$',
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(25),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Text(description),
          ],
        ),
      ),
    );
  }
}
