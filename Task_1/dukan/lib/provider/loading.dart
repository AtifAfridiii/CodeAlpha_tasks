import 'package:flutter/material.dart';

class Loading with ChangeNotifier {
  bool _toggle = true;
  get toggle => _toggle;
  void settoggle() {
    _toggle = !_toggle;
    notifyListeners();
  }

  void setToglle2(bool value) {
    _toggle = value;
    notifyListeners();
  }
}
