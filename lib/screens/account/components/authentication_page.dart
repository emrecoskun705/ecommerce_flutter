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
              color: Color(0xFF8ECAE6),
            ),
          ),
          bottom: TabBar(
            labelColor: Color(0xFF8ECAE6),
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
