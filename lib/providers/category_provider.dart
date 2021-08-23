import 'package:ecommerce_flutter/models/category.dart';
import 'package:ecommerce_flutter/services/category_api.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider with ChangeNotifier {
  List<Category>? categoryList;
  bool isLoading = true;

  Future fetchCategories(String slug) async {
    setIsLoading(true);
    var categories = await CategoryApi().fetchCategories(slug);
    setCategoryList(categories);
    setIsLoading(false);
  }

  void setCategoryList(List<Category> categoryList) {
    this.categoryList = categoryList;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    this.isLoading = value;
    notifyListeners();
  }
}
