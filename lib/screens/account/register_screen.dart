import 'package:flutter/material.dart';
import 'package:ecommerce_flutter/constants.dart';
import 'package:ecommerce_flutter/screens/components/rounded_button.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
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
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                decoration: kAccountInputDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                decoration: kAccountInputDecoration.copyWith(
                  hintText: 'Password',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                decoration: kAccountInputDecoration.copyWith(
                  hintText: 'Confirm Password',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              RoundedButton(
                colour: Color(0xFFFFB703),
                title: 'Register',
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
