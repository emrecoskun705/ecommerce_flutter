import 'package:ecommerce_flutter/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kServerURL = 'http://192.168.0.108:8000';
const kServerAuthApiURL = '$kServerURL/rest-auth';
const kServerApiURL = '$kServerURL/api';

const kSearchBarTag = 'searchBarTag';
const kSearchBarCategoryTag = 'searchBarCategoryTag';

const kWhiteColor = Color(0xFFFAFAFA);

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

EdgeInsets kButtonDefaultEdgeInsets() {
  return EdgeInsets.symmetric(
      vertical: getProportionateScreenHeight(30),
      horizontal: getProportionateScreenWidth(50));
}
