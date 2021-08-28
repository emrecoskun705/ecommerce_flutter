import 'package:ecommerce_flutter/providers/persistent_tab_provider.dart';
import 'package:ecommerce_flutter/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_flutter/constants.dart';
import 'package:ecommerce_flutter/screens/components/rounded_button.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();

  void _register() {
    Provider.of<UserProvider>(context, listen: false)
        .registerUser(email.text, password1.text, password2.text)
        .then((value) {
      if (value) {
        //redirect to home tab
        Provider.of<PersistentTabProvider>(context, listen: false).changeTab(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Register',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Color(0xFFFB8500)),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: email,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null) return 'Please enter e-mail address';
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(val)) {
                      return 'Please enter valid e-mail address';
                    }

                    return null;
                  },
                  decoration: kAccountInputDecoration.copyWith(
                    labelText: 'E-mail',
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: password1,
                  validator: (val) {
                    if (password1.text == '') return 'Please enter a password';
                    if (password1.text.length < 8)
                      return 'Password must be at least 8 characters';
                    if (password1.text != password2.text)
                      return 'Passwords do not match';
                    if (!password1.text.contains(RegExp(r'[A-Za-z]')))
                      return 'Password must contain at least 1 letter';
                    return null;
                  },
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: kAccountInputDecoration.copyWith(
                    labelText: 'Password',
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: password2,
                  validator: (val) {
                    if (password2.text == '') return 'Please enter a password';
                    if (password2.text.length < 8)
                      return 'Password must be at least 8 characters';
                    if (password1.text != password2.text)
                      return 'Passwords do not match';
                    if (!password2.text.contains(RegExp(r'[A-Za-z]')))
                      return 'This password is too numeric';
                    return null;
                  },
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: kAccountInputDecoration.copyWith(
                    labelText: 'Confirm password',
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RoundedButton(
                  colour: Color(0xFFFFB703),
                  title: 'Register',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _register();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
