import 'package:ecommerce_flutter/models/product.dart';
import 'package:ecommerce_flutter/size_config.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart' show GFCarousel;

class ProductImageCarousel extends StatefulWidget {
  final Product product;

  ProductImageCarousel({required this.product});

  @override
  _ProductImageCarouselState createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  @override
  Widget build(BuildContext context) {
    return GFCarousel(
      enableInfiniteScroll: false,
      autoPlay: false,
      height: getProportionateScreenHeight(400),
      items: widget.product.images.map(
        (url) {
          int index = widget.product.images.indexOf(url);
          return Container(
            margin: EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(10.0)),
                  decoration: BoxDecoration(
                      // color: Color(0xFF979797).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15)),
                  // if index == 0 hero otherwise don't use hero because hero does not work for all of them in this situation
                  child: index == 0
                      ? Hero(
                          tag: widget.product.id.toString(),
                          child: Image.network(
                            'http://192.168.0.108:8000$url',
                            fit: BoxFit.fill,
                          ),
                        )
                      : Image.network(
                          'http://192.168.0.108:8000$url',
                          fit: BoxFit.fill,
                        ),
                ),
              ),
            ),
          );
        },
      ).toList(),
      onPageChanged: (index) {
        setState(() {
          index;
        });
      },
    );
  }
}
