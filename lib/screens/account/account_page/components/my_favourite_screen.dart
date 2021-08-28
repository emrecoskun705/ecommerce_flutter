import 'package:ecommerce_flutter/providers/account/favourite_provider.dart';
import 'package:ecommerce_flutter/screens/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../../size_config.dart';

class MyFavouriteScreen extends StatefulWidget {
  const MyFavouriteScreen({Key? key}) : super(key: key);

  @override
  _MyFavouriteScreenState createState() => _MyFavouriteScreenState();
}

class _MyFavouriteScreenState extends State<MyFavouriteScreen> {
  FavouriteProvider _favouriteProvider = FavouriteProvider();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _favouriteProvider.fetchFavouriteProductList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black.withOpacity(0.3)),
        backgroundColor: Color(0xFFFFAFAFA),
        centerTitle: true,
        title: Text(
          'Emre\'s E-Commerce',
          style: TextStyle(
            color: Color(0xFF8ECAE6),
          ),
        ),
      ),
      body: ChangeNotifierProvider.value(
        value: _favouriteProvider,
        child: Consumer<FavouriteProvider>(
          builder: (context, data, _) {
            if (data.isLoading) {
              return ModalProgressHUD(
                inAsyncCall: true,
                child: Container(
                  color: Colors.white,
                ),
              );
            } else {
              return Container(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(5)),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (itemWidth / itemHeight),
                      // mainAxisExtent: 250,
                      mainAxisSpacing: getProportionateScreenHeight(5)),
                  itemCount: data.productList.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: data.productList[index]);
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
