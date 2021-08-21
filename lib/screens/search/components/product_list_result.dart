import 'package:ecommerce_flutter/providers/product/search_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  final String query;

  ProductListPage({required this.query});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  SearchProductProvider searchProductProvider = SearchProductProvider();
  ScrollController _sc = ScrollController();

  @override
  void initState() {
    // fetch initial product
    searchProductProvider.fetchData(widget.query);
    super.initState();

    // if scroll's position at maxScrollExtent fetch new products(new page)
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        searchProductProvider.fetchData(widget.query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }

  Widget _buildList() {
    return ChangeNotifierProvider.value(
      value: searchProductProvider,
      child: Consumer<SearchProductProvider>(
        builder: (context, data, index) => ListView.builder(
            controller: _sc,
            // purpose of itemCount + 1 is progress indicator.
            // progress indicator is always at the end but it only appears when isLoading=true
            itemCount: data.productList.length + 1,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            itemBuilder: (BuildContext context, int index) {
              if (index == data.productList.length) {
                return _buildProgressIndicator();
              }
              return ListTile(
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(data.productList[index].image),
                ),
                title: Text(data.productList[index].title),
                subtitle: Text(data.productList[index].price.toString()),
              );
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
