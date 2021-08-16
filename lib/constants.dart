import 'package:ecommerce_flutter/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const kServerAuthApiURL = 'http://192.168.0.108:8000/rest-auth';
const kServerApiURL = 'http://127.0.0.1:8000/api';

const kAccountInputDecoration = InputDecoration(
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  // enabledBorder: OutlineInputBorder(
  //   borderSide: BorderSide(color: Color(0xFFFFB703), width: 1.0),
  //   borderRadius: BorderRadius.all(Radius.circular(16.0)),
  // ),
  // focusedBorder: OutlineInputBorder(
  //   borderSide: BorderSide(color: Color(0xFFFFB703), width: 1.0),
  //   borderRadius: BorderRadius.all(Radius.circular(16.0)),
  // ),
);
