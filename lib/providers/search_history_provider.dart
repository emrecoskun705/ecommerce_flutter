import 'package:ecommerce_flutter/utils/user_search_history.dart';
import 'package:flutter/cupertino.dart';

class SearchHistoryProvider with ChangeNotifier {
  List<String> searchHistory = [];
  bool loading = true;

  void addItem(String item) async {
    UserSearchHistory.addSearchHistory(item);
    setLoading(true);
    searchHistory = await UserSearchHistory.getSearchHistory();
    setLoading(false);
    notifyListeners();
  }

  void getSearchHistory() async {
    setLoading(true);
    searchHistory = await UserSearchHistory.getSearchHistory();
    setLoading(false);
  }

  void clearHistory() async {
    await UserSearchHistory.clearHistory();
    searchHistory = [];
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}
