import 'package:flutter/material.dart';

class Iconcolor with ChangeNotifier {
  bool _iconColor1 = false;
  bool get iconColor1 => _iconColor1;

  bool _iconColor2 = false;
  bool get iconColor2 => _iconColor2;

  bool _iconColor3 = false;
  bool get iconColor3 => _iconColor3;

  bool _iconColor4 = false;
  bool get iconColor4 => _iconColor4;

  void seticonCOlor1() {
    _iconColor1 = !iconColor1;
    notifyListeners();
  }

  void seticonCOlor2() {
    _iconColor2 = !iconColor2;
    notifyListeners();
  }

  void seticonCOlor3() {
    _iconColor3 = !iconColor3;
    notifyListeners();
  }

  void seticonCOlor4() {
    _iconColor4 = !iconColor4;
    notifyListeners();
  }
}
