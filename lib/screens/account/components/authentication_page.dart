import 'package:ecommerce_flutter/screens/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class AuthenticationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFFFAFAFA),
          elevation: 0,
          title: Text(
            'Emre\'s E-Commerce',
            style: TextStyle(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          bottom: TabBar(
            labelColor: Colors.lightBlueAccent,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                child: Text(
                  'Log in',
                ),
              ),
              Tab(
                child: Text('Register'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LoginScreen(),
            RegisterScreen(),
          ],
        ),
      ),
    );
  }
}
