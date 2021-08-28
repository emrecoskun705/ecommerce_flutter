import 'package:ecommerce_flutter/providers/UserProvider.dart';
import 'package:ecommerce_flutter/screens/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

//user detail page
class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void logout() async {
      await Provider.of<UserProvider>(context, listen: false).logout();
    }

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<UserProvider>(context).isLoading,
        child: Center(
          child: Column(
            children: [
              Text(
                'You have logged in',
                style: TextStyle(fontSize: 25.0),
              ),
              RoundedButton(
                colour: Color(0xFFFFB703),
                title: 'Log out',
                onPressed: logout,
              )
            ],
          ),
        ),
      ),
    );
  }
}
