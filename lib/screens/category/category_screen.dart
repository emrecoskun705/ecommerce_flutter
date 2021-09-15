import 'package:ecommerce_flutter/providers/category_provider.dart';
import 'package:ecommerce_flutter/screens/category/components/category_list.dart';
import 'package:ecommerce_flutter/screens/category/components/product_list_category.dart';
import 'package:ecommerce_flutter/screens/components/search_bar.dart';
import 'package:ecommerce_flutter/screens/search/search.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_flutter/size_config.dart';

class CategoryScreen extends StatefulWidget {
  final String slug;
  final bool showAll;
  CategoryScreen({required this.slug, required this.showAll});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  static TextEditingController _controller = TextEditingController();
  CategoryProvider categoryProvider = CategoryProvider();

  @override
  void initState() {
    categoryProvider.fetchCategories(widget.slug);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                forceElevated: innerBoxIsScrolled,
                floating: true,
                title: Center(
                  child: Text(
                    'Emre\'s E-Commerce',
                    style: TextStyle(
                      color: Color(0xFF8ECAE6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                elevation: 0,
                backgroundColor: Colors.white,
              )
            ];
          },
          body: Column(
            children: [
              GestureDetector(
                onTap: () {
                  // showSearch(context: context, delegate: SearchScreen());
                  pushNewScreen(context,
                      screen: SearchScreen(),
                      pageTransitionAnimation: PageTransitionAnimation.fade);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenHeight(10)),
                  child: Hero(
                      tag: 'searchBarTag',
                      child:
                          SearchBar(enabled: false, controller: _controller)),
                ),
              ),
              Flexible(
                child: ChangeNotifierProvider.value(
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
                        // show product list
                        if (data.categoryList!.length <= 1 || widget.showAll) {
                          return ProductListCategory(categorySlug: widget.slug);
                        }

                        // show category list
                        return CategoryList(widget, data);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
