import 'package:ecommerce_flutter/screens/components/search_bar.dart';
import 'package:ecommerce_flutter/screens/search/components/history_search_list.dart';
import 'package:ecommerce_flutter/screens/search/components/small_title_widget.dart';
import 'package:ecommerce_flutter/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_flutter/constants.dart';

import 'package:ecommerce_flutter/screens/search/components/popular_search_list.dart';

class SearchScreen extends StatelessWidget {
  static TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _spacer = SizedBox(height: getProportionateScreenHeight(20));
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: kSearchBarTag,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(10),
                    horizontal: getProportionateScreenWidth(20)),
                child: SearchBar(
                  enabled: true,
                  controller: _controller,
                ),
              ),
            ),
            _spacer,
            SmallTitle('Popular'),
            PopularSearchList(),
            _spacer,
            SmallTitle('History'),
            HistorySearchList(),
          ],
        ),
      ),
    );
  }
}
