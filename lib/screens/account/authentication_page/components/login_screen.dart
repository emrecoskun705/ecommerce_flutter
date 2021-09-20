import 'package:ecommerce_flutter/providers/persistent_tab_provider.dart';
import 'package:ecommerce_flutter/providers/UserProvider.dart';
import 'package:ecommerce_flutter/screens/account/authentication_page/components/google_login.dart';
import 'package:ecommerce_flutter/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_flutter/constants.dart';
import 'package:ecommerce_flutter/screens/components/rounded_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _login() {
    //fetchUser = authenticate user
    Provider.of<UserProvider>(context, listen: false)
        .fetchUser(emailController.text, passwordController.text)
        .then((value) {
      if (value) {
        //redirect to home tab
        Provider.of<PersistentTabProvider>(context, listen: false).changeTab(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Provider.of<UserProvider>(context).isLoading,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.0),
                  buildEmail(context),
                  SizedBox(height: 20.0),
                  buildPassword(context),
                  SizedBox(height: 20.0),
                  buildLoginButton(),
                  SizedBox(height: 20.0),
                  Center(
                    child: Text(
                      '- OR -',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  GoogleLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding buildLoginButton() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
      child: RoundedButton(
        primaryColor: Colors.white,
        bgColor: Colors.lightBlueAccent,
        title: 'Log In',
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _login();
          }
        },
      ),
    );
  }

  TextFormField buildPassword(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      validator: (val) {
        if (val == '') {
          return 'This field is required';
        }
        return null;
      },
      enabled: !Provider.of<UserProvider>(context).isLoading,
      textAlign: TextAlign.center,
      obscureText: true,
      decoration: kAccountInputDecoration.copyWith(
        labelText: 'Password',
        errorText: Provider.of<UserProvider>(context).isError
            ? Provider.of<UserProvider>(context).getMessage()
            : null,
      ),
    );
  }

  TextFormField buildEmail(BuildContext context) {
    return TextFormField(
      controller: emailController,
      validator: (val) {
        if (val == '') {
          return 'This field is required';
        }
        return null;
      },
      enabled: !Provider.of<UserProvider>(context).isLoading,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.emailAddress,
      decoration: kAccountInputDecoration.copyWith(
        labelText: 'E-mail',
        errorText: Provider.of<UserProvider>(context).isError ? '' : null,
      ),
    );
  }
}
