import 'package:ecommerce_flutter/models/cart/address.dart';
import 'package:ecommerce_flutter/providers/address_provider.dart';
import 'package:ecommerce_flutter/screens/cart/components/checkout_page.dart';
import 'package:ecommerce_flutter/screens/components/rounded_button.dart';
import 'package:ecommerce_flutter/size_config.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../constants.dart';

class AddressFormScreen extends StatefulWidget {
  const AddressFormScreen({Key? key}) : super(key: key);

  @override
  _AddressFormScreenState createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController addressTitle = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController province = TextEditingController();
  TextEditingController zip = TextEditingController();
  TextEditingController detail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: addressTitle,
                              decoration: kAccountInputDecoration.copyWith(
                                labelText: 'Address Title',
                              ),
                              validator: (val) {
                                if (addressTitle.text == '') {
                                  return 'Required';
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 20),
                          Flexible(
                            child: TextFormField(
                              controller: country,
                              decoration: kAccountInputDecoration.copyWith(
                                labelText: 'Country',
                              ),
                              validator: (val) {
                                if (country.text == '') {
                                  return 'Required';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(40)),
                      TextFormField(
                        controller: detail,
                        decoration: kAccountInputDecoration.copyWith(
                          labelText: 'Address Detail',
                        ),
                        validator: (val) {
                          if (detail.text == '') {
                            return 'Required';
                          }
                        },
                      ),
                      SizedBox(height: getProportionateScreenHeight(40)),
                      Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: zip,
                              decoration: kAccountInputDecoration.copyWith(
                                labelText: 'Zip',
                              ),
                              validator: (val) {
                                if (zip.text == '') {
                                  return 'Required';
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 20),
                          Flexible(
                            child: TextFormField(
                              controller: province,
                              decoration: kAccountInputDecoration.copyWith(
                                labelText: 'Province',
                              ),
                              validator: (val) {
                                if (province.text == '') {
                                  return 'Required';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      RoundedButton(
                        colour: Colors.lightBlueAccent,
                        title: 'Continue checkout',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            Address? address = await AddressProvider()
                                .createAddress(Address(
                                    12,
                                    addressTitle.text,
                                    country.text,
                                    province.text,
                                    zip.text,
                                    detail.text));
                            await AddressProvider()
                                .addAddressToOrder(address!.id);
                            pushNewScreen(context, screen: CheckoutPage());
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Color(0xFFFAFAFA),
      title: Text(
        'Create Address',
        style: TextStyle(
          color: Colors.black.withOpacity(0.7),
        ),
      ),
    );
  }
}
