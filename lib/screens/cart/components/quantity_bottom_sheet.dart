import 'package:ecommerce_flutter/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuantityBottomSheet extends StatelessWidget {
  final int orderProductId;
  const QuantityBottomSheet({
    Key? key,
    required this.orderProductId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Center(
              child: Text('Select Quantity'),
            ),
            trailing: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.close),
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  int _quantity = index + 1;
                  return InkWell(
                    onTap: () async {
                      // Navigator.pop(context);
                      bool success = await Provider.of<OrderProvider>(context,
                              listen: false)
                          .changeQuantity(orderProductId, _quantity);
                      Navigator.pop(context);
                      if (!success) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Invalid amount of product quantity')));
                      }
                    },
                    child: ListTile(
                      title: Center(child: Text(_quantity.toString())),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
