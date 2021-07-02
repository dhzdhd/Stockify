import 'package:flutter/material.dart';

class NavBarModel extends ChangeNotifier {
  var pageIndex = 0;

  void changePage(int index) {
    pageIndex = index;
    notifyListeners();
  }
}