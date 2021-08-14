import 'package:ecommerce_flutter/components/search.dart';
import 'package:ecommerce_flutter/screens/account_screen.dart';
import 'package:ecommerce_flutter/screens/cart_screen.dart';
import 'package:ecommerce_flutter/screens/category_screen.dart';
import 'package:ecommerce_flutter/screens/home_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //current_index refers to which page we see initial value is home
  int _currentIndex = 0;
  final screens = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Emre\'s E-Commerce',
          style: TextStyle(
            color: Colors.lightBlueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              showSearch(context: context, delegate: SearchBar());
            },
            icon: Icon(
              Icons.search,
              color: Colors.lightBlue,
            ),
          ),
        ],
        elevation: 10,
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
    );
  }
}
