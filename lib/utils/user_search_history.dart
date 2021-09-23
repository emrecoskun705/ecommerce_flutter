import 'package:shared_preferences/shared_preferences.dart';

class UserSearchHistory {
  static Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  static String searchHistoryKey = 'searchHistory';

  static Future<List<String>> getSearchHistory() async {
    SharedPreferences prefs = await _pref;
    List<String>? history = prefs.getStringList(searchHistoryKey);
    if (history == null) {
      return [];
    }

    return history;
  }

  static void addSearchHistory(String searchItem) async {
    searchItem = searchItem.toLowerCase();
    SharedPreferences prefs = await _pref;
    List<String>? history = prefs.getStringList(searchHistoryKey);
    if (history == null) {
      await prefs.setStringList(searchHistoryKey, [searchItem]);
    } else {
      if (!history.contains(searchItem)) {
        history.add(searchItem);
        await prefs.setStringList(searchHistoryKey, history);
      }
    }
  }

  static Future clearHistory() async {
    SharedPreferences prefs = await _pref;
    await prefs.setStringList(searchHistoryKey, []);
  }
}
