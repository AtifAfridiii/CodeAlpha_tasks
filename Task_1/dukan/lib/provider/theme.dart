import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  var _thememode = ThemeMode.light;
  ThemeMode get Thememode => _thememode;

  void setTheme(ThemeMode themeMode) {
    _thememode = themeMode;
    notifyListeners();
  }
}
