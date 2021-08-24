import 'package:ecommerce_flutter/models/category.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../size_config.dart';
import '../category_screen.dart';

class CategoryList extends StatelessWidget {
  final widget;
  final data;

  CategoryList(this.widget, this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.slug == 'root' ? 'Categories' : data.categoryList![0].name,
          style: TextStyle(
              fontSize: getProportionateScreenHeight(25), color: Colors.black),
        ),
        backgroundColor: Color(0xFFFAFAFA),
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: data.categoryList!.length,
          itemBuilder: (context, index) {
            Category category = data.categoryList![index];
            return GestureDetector(
              onTap: () {
                pushNewScreen(context,
                    screen: CategoryScreen(
                      slug: category.slug,
                      showAll: category.slug == widget.slug,
                    ));
              },
              child: Card(
                margin: EdgeInsets.all(0),
                elevation: 3,
                child: ListTile(
                  leading: Text(
                    category.slug == widget.slug
                        ? 'Show All ${category.name}'
                        : category.name,
                    style:
                        TextStyle(fontSize: getProportionateScreenHeight(18)),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right_sharp),
                ),
              ),
            );
          }),
    );
  }
}
