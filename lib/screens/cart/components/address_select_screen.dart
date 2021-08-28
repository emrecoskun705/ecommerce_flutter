import 'package:ecommerce_flutter/providers/address_provider.dart';
import 'package:ecommerce_flutter/providers/order_provider.dart';
import 'package:ecommerce_flutter/screens/cart/components/address_form_screen.dart';
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
      appBar: buildAppBar(context),
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
                        child: InkWell(
                          onTap: () {
                            Provider.of<OrderProvider>(context, listen: false)
                                .order!
                                .shippingAddress = data.addressList[index];
                            Provider.of<OrderProvider>(context, listen: false)
                                .order!
                                .billingAddress = data.addressList[index];
                            Provider.of<AddressProvider>(context, listen: false)
                                .addAddressToOrder(data.addressList[index].id);
                            pushNewScreen(context, screen: CheckoutPage());
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Icon(Icons.location_city),
                              title: Text(
                                data.addressList[index].addressTitle,
                                maxLines: 1,
                              ),
                              subtitle: Text(
                                '${data.addressList[index].detail} lorem ipsum lorem ipsum lorem ipsum',
                                maxLines: 2,
                              ),
                              trailing: Text(
                                '${data.addressList[index].province}/${data.addressList[index].country}',
                                maxLines: 1,
                              ),
                            ),
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

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
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
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => AddressFormScreen()));
            // pushNewScreen(context, screen: AddressFormScreen());
          },
          icon: Icon(
            Icons.add,
            size: getProportionateScreenHeight(40),
            color: Colors.black.withOpacity(0.4),
          ),
        ),
      ],
    );
  }
}
