import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

//This class is used for changing the current tab
class PersistentTabProvider with ChangeNotifier {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  void changeTab(int value) {
    _controller.jumpToTab(value);
    notifyListeners();
  }

  PersistentTabController get controller => _controller;
}
