import 'package:ecommerce_flutter/models/category.dart';
import 'package:ecommerce_flutter/providers/category_provider.dart';
import 'package:ecommerce_flutter/size_config.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  final String slug;

  CategoryScreen({required this.slug});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryProvider categoryProvider = CategoryProvider();

  @override
  void initState() {
    categoryProvider.fetchCategories(widget.slug);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider.value(
        value: categoryProvider,
        child: Consumer<CategoryProvider>(
          builder: (context, data, _) {
            if (data.isLoading) {
              return Container(
                child: ModalProgressHUD(
                  inAsyncCall: true,
                  child: Container(),
                ),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(20),
                        horizontal: getProportionateScreenWidth(15)),
                    child: Text(
                      widget.slug == 'root'
                          ? 'Categories'
                          : data.categoryList![0].name,
                      style:
                          TextStyle(fontSize: getProportionateScreenHeight(25)),
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                        itemCount: data.categoryList!.length,
                        itemBuilder: (context, index) {
                          Category category = data.categoryList![index];
                          return GestureDetector(
                            onTap: () {
                              pushNewScreen(context,
                                  screen: CategoryScreen(
                                      slug: data.categoryList![index].slug));
                            },
                            child: Card(
                              margin: EdgeInsets.all(0),
                              elevation: 3,
                              child: ListTile(
                                leading: Text(
                                  category.slug == widget.slug
                                      ? 'Show All ${category.name}'
                                      : category.name,
                                  style: TextStyle(
                                      fontSize:
                                          getProportionateScreenHeight(18)),
                                ),
                                trailing:
                                    Icon(Icons.keyboard_arrow_right_sharp),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
