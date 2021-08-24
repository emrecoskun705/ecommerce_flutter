import 'package:ecommerce_flutter/providers/category_provider.dart';
import 'package:ecommerce_flutter/screens/category/components/category_list.dart';
import 'package:ecommerce_flutter/screens/category/components/product_list_category.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  final String slug;
  final bool showAll;
  CategoryScreen({required this.slug, required this.showAll});

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
    );
  }
}
