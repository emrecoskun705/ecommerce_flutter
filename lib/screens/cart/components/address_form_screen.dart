import 'package:ecommerce_flutter/models/cart/address.dart';
import 'package:ecommerce_flutter/screens/components/rounded_button.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class AddressFormScreen extends StatefulWidget {
  const AddressFormScreen({Key? key}) : super(key: key);

  @override
  _AddressFormScreenState createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController addressTitle = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController province = TextEditingController();
  TextEditingController zip = TextEditingController();
  TextEditingController detail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xFFFAFAFA),
        title: Text(
          'Create Address',
          style: TextStyle(
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ),
      body: Container(
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
                        ),
                      ),
                      SizedBox(width: 20),
                      Flexible(
                        child: TextFormField(
                          controller: country,
                          decoration: kAccountInputDecoration.copyWith(
                            labelText: 'Country',
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: detail,
                    decoration: kAccountInputDecoration.copyWith(
                      labelText: 'Address Detail',
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: zip,
                          decoration: kAccountInputDecoration.copyWith(
                            labelText: 'Zip',
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Flexible(
                        child: TextFormField(
                          controller: province,
                          decoration: kAccountInputDecoration.copyWith(
                            labelText: 'Province',
                          ),
                        ),
                      ),
                    ],
                  ),
                  RoundedButton(
                    colour: Colors.lightBlueAccent,
                    title: 'Create Address',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
