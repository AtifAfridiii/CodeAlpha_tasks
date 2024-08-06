import 'package:flutter/material.dart';

class ProductColor with ChangeNotifier {
  int? _selectedColorIndex;
  int? _selectedSizeIndex;

  get SelectedColorIndex => _selectedColorIndex;
  get SelectedSizedIndex => _selectedSizeIndex;

  void setColorIndex(int index) {
    _selectedColorIndex = index;
    notifyListeners();
  }

  void setSizedIndex(int index) {
    _selectedSizeIndex = index;
    notifyListeners();
  }
}
