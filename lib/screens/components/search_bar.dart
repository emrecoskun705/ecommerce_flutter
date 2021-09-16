import 'package:ecommerce_flutter/screens/search/components/product_list_result.dart';
import 'package:ecommerce_flutter/size_config.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SearchBar extends StatefulWidget {
  final bool enabled;
  final TextEditingController controller;

  SearchBar({required this.enabled, required this.controller});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String previousText = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      // type: MaterialType.transparency,
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      child: TextField(
        controller: this.widget.controller,
        onChanged: (val) {
          setState(() {
            previousText = val;
          });
        },
        maxLines: 1,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          pushNewScreen(context,
              screen: ProductListPage(
                query: value,
              ));
        },
        enabled: widget.enabled,
        autofocus: widget.enabled,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: getProportionateScreenHeight(35),
            color: Colors.grey,
          ),
          suffixIcon: previousText.length > 0
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    this.widget.controller.clear();
                    setState(() {
                      previousText = '';
                    });
                  },
                )
              : null,
          hintText: 'Search product',
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
