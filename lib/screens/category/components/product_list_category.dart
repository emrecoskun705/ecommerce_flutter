import 'package:ecommerce_flutter/providers/product/search_product_provider.dart';
import 'package:ecommerce_flutter/screens/components/product_card.dart';
import 'package:ecommerce_flutter/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListCategory extends StatefulWidget {
  final String categorySlug;

  ProductListCategory({required this.categorySlug});

  @override
  _ProductListCategoryState createState() => _ProductListCategoryState();
}

class _ProductListCategoryState extends State<ProductListCategory> {
  SearchProductProvider searchProductProvider = SearchProductProvider();
  ScrollController _sc = ScrollController();

  @override
  void initState() {
    // fetch initial product
    searchProductProvider.fetchCategoryProductData(widget.categorySlug);
    super.initState();

    // if scroll's position at maxScrollExtent fetch new products(new page)
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        searchProductProvider.fetchCategoryProductData(widget.categorySlug);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5)),
      color: Colors.grey.withOpacity(0.1),
      child: _buildList(itemHeight, itemWidth),
    );
  }

  Widget _buildList(itemHeight, itemWidth) {
    return ChangeNotifierProvider.value(
      value: searchProductProvider,
      child: Consumer<SearchProductProvider>(
        builder: (context, data, index) => GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
                // mainAxisExtent: 250,
                mainAxisSpacing: getProportionateScreenHeight(5)),
            controller: _sc,
            // purpose of itemCount + 1 is progress indicator.
            // progress indicator is always at the end but it only appears when isLoading=true
            itemCount: data.productList.length + 1,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            itemBuilder: (BuildContext context, int index) {
              if (index == data.productList.length) {
                return _buildProgressIndicator();
              }
              return ProductCard(product: data.productList[index]);
            }),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: searchProductProvider.isLoading ? 1.0 : 00,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }
}
