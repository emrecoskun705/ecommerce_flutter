import 'package:ecommerce_flutter/models/product.dart';
import 'package:ecommerce_flutter/providers/UserProvider.dart';
import 'package:ecommerce_flutter/screens/components/rounded_button.dart';
import 'package:ecommerce_flutter/screens/details/components/product_description.dart';
import 'package:ecommerce_flutter/screens/details/components/product_image_carousel.dart';
import 'package:ecommerce_flutter/services/product/product_detail_api.dart';
import 'package:ecommerce_flutter/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  final int productId;

  ProductDetail({required this.productId});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Product>(
      future: ProductDetailApi.fetchData(widget.productId),
      builder: (BuildContext context, AsyncSnapshot<Product> snapshot) {
        // if connection state is not done it will show a loading screen
        if (snapshot.connectionState != ConnectionState.done) {
          return ModalProgressHUD(
            inAsyncCall: true,
            child: Container(
              color: Colors.white,
            ),
          );
        }

        if (snapshot.hasError) {
          return Text('error');
        }

        // when api fetches the future and if has data, product detail screen will appear
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                snapshot.data!.title,
                style: TextStyle(color: Colors.black.withOpacity(0.7)),
              ),
              actions: [
                Provider.of<UserProvider>(context).isLoggedIn
                    ? IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.heart_fill,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      )
                    : SizedBox(),
              ],
              backgroundColor: Color(0xFFFFF),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenHeight(15),
                    vertical: getProportionateScreenWidth(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      snapshot.data!.title,
                      style:
                          TextStyle(fontSize: getProportionateScreenWidth(14)),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    ProductImageCarousel(
                      product: snapshot.data!,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(14),
                    ),
                    ProductDescription(
                      price: snapshot.data!.price,
                      discountPrice: snapshot.data!.discountPrice,
                      description: snapshot.data!.description,
                    ),
                    RoundedButton(
                      colour: Colors.lightBlueAccent,
                      title: 'Add to cart',
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return Text('some other error');
      },
    );
  }
}
