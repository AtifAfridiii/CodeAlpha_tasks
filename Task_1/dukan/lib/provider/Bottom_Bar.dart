import 'package:flutter/material.dart';

class Selected_Index with ChangeNotifier {
  int _selectedIndex = 0;
  int get SelectedIndex => _selectedIndex;

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
