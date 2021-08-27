import 'package:ecommerce_flutter/providers/address_provider.dart';
import 'package:ecommerce_flutter/providers/order_provider.dart';
import 'package:ecommerce_flutter/screens/cart/components/checkout_page.dart';
import 'package:ecommerce_flutter/size_config.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class AddressSelectScreen extends StatefulWidget {
  @override
  _AddressSelectScreenState createState() => _AddressSelectScreenState();
}

class _AddressSelectScreenState extends State<AddressSelectScreen> {
  AddressProvider _addressProvider = AddressProvider();

  @override
  void initState() {
    _addressProvider.fetchAddressList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xFFFAFAFA),
        title: Text(
          'Select or Create Address',
          style: TextStyle(
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add,
              size: getProportionateScreenHeight(40),
              color: Colors.black.withOpacity(0.4),
            ),
          ),
        ],
      ),
      body: ChangeNotifierProvider.value(
        value: _addressProvider,
        child: Consumer<AddressProvider>(
          builder: (context, data, _) {
            if (data.isLoading) {
              return ModalProgressHUD(
                inAsyncCall: true,
                child: Container(
                  color: Colors.white,
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: data.addressList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Text(
                              data.addressList[index].addressTitle,
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(20),
                              ),
                            ),
                            onTap: () {
                              Provider.of<OrderProvider>(context, listen: false)
                                  .order!
                                  .shippingAddress = data.addressList[index];
                              Provider.of<OrderProvider>(context, listen: false)
                                  .order!
                                  .billingAddress = data.addressList[index];
                              Provider.of<AddressProvider>(context,
                                      listen: false)
                                  .addAddressToOrder(
                                      data.addressList[index].id);
                              pushNewScreen(context, screen: CheckoutPage());
                            },
                          ),
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
