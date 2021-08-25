import 'package:ecommerce_flutter/models/cart/order_product.dart';
import 'package:ecommerce_flutter/providers/order_provider.dart';
import 'package:ecommerce_flutter/screens/cart/components/cart_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';

class OrderProducts extends StatefulWidget {
  const OrderProducts({Key? key}) : super(key: key);

  @override
  _OrderProductsState createState() => _OrderProductsState();
}

class _OrderProductsState extends State<OrderProducts> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<OrderProvider>(context, listen: false).fetchOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<OrderProvider>(context).isLoading
        ? Container(
            child: ModalProgressHUD(
              inAsyncCall: true,
              child: Container(),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: ListView.builder(
              itemCount:
                  Provider.of<OrderProvider>(context).order!.productList.length,
              itemBuilder: (context, index) {
                OrderProduct orderProduct =
                    context.watch<OrderProvider>().order!.productList[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Dismissible(
                    key: Key(orderProduct.product.id.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      context
                          .read<OrderProvider>()
                          .order!
                          .productList
                          .remove(orderProduct);
                    },
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          SvgPicture.asset("assets/icons/Trash.svg"),
                        ],
                      ),
                    ),
                    child: CartProductCard(
                      orderProduct: orderProduct,
                    ),
                  ),
                );
              },
            ),
          );
  }
}
