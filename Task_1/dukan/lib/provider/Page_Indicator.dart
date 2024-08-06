import 'package:flutter/material.dart';

class Smooth_Page with ChangeNotifier {
  int _initialPage = 0;
  int get InitialPage => _initialPage;

  void setPage(ind) {
    _initialPage = ind;
    notifyListeners();
  }
}
