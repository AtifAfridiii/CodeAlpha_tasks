import 'package:flutter/material.dart';

class dropValue extends ChangeNotifier {
  String _value = '';

  String get Value => _value;

  void setValue(newValue) {
    _value = newValue;
    notifyListeners();
  }
}
