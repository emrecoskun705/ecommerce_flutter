import 'package:ecommerce_flutter/models/cart/order_product.dart';
import 'package:ecommerce_flutter/providers/order_provider.dart';
import 'package:ecommerce_flutter/screens/cart/components/cart_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';

class OrderProducts extends StatefulWidget {
  @override
  _OrderProductsState createState() => _OrderProductsState();
}

class _OrderProductsState extends State<OrderProducts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Consumer<OrderProvider>(
        builder: (context, data, _) {
          var order = data.order;
          return ListView.builder(
            itemCount: order.productList.length,
            itemBuilder: (context, index) {
              OrderProduct orderProduct = order.productList[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Dismissible(
                  key: Key(orderProduct.product.id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    data.deleteOrderProduct(orderProduct);
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
          );
        },
      ),
    );
  }
}
