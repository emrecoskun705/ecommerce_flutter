import 'package:ecommerce_flutter/providers/persistent_tab_provider.dart';
import 'package:ecommerce_flutter/providers/product/trend_product_provider.dart';
import 'package:ecommerce_flutter/providers/UserProvider.dart';
import 'package:ecommerce_flutter/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_flutter/screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PersistentTabProvider()),
        ChangeNotifierProvider(create: (_) => TrendProductProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}
