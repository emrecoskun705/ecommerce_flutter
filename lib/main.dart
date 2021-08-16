import 'package:ecommerce_flutter/providers/PersistentTabProvider.dart';
import 'package:ecommerce_flutter/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_flutter/screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PersistentTabProvider()),
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
