import 'package:ecommerce_flutter/models/minimal_product.dart';
import 'package:ecommerce_flutter/providers/order_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../../size_config.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  OrderListProvider _orderListProvider = OrderListProvider();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _orderListProvider.fetchOrderProductList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        value: _orderListProvider,
        child: Consumer<OrderListProvider>(
          builder: (context, data, _) {
            if (data.isLoading) {
              return ModalProgressHUD(
                inAsyncCall: true,
                child: Container(
                  color: Colors.white,
                ),
              );
            } else {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.grey.withOpacity(0.2),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(10),
                          horizontal: 10),
                      child: Text(
                        'My Orders',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: getProportionateScreenHeight(30),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(5)),
                      child: ListView.builder(
                        itemCount: data.orderProductList.length,
                        itemBuilder: (context, index) {
                          MinimalProduct product =
                              data.orderProductList[index].product;
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              leading: Image.network(product.image),
                              title: Text(
                                product.title,
                                maxLines: 1,
                              ),
                              subtitle: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //if product has discount price
                                  Text(
                                    product.discountPrice != 0.0
                                        ? '\$${product.discountPrice}'
                                        : '\$${product.price}',
                                    style: TextStyle(
                                      fontSize: getProportionateScreenWidth(18),
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF979797),
                                    ),
                                  ),
                                  product.discountPrice != 0.0
                                      ? Text(
                                          '\$${product.price}',
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationThickness:
                                                getProportionateScreenHeight(
                                                    2.85),
                                            fontSize:
                                                getProportionateScreenWidth(10),
                                            fontWeight: FontWeight.w600,
                                            color: Colors.red,
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                              trailing: Text(data
                                  .orderProductList[index].quantity
                                  .toString()),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
