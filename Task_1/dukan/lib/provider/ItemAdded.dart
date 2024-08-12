import 'package:dukan/screens/CartScreen/box.dart';
import 'package:dukan/screens/CartScreen/cart_model.dart';
import 'package:flutter/material.dart';

class ItemAdded with ChangeNotifier {
  final Map<int, CartModel> _items = {};

  double _totalPrice = 0.0;

  int getItemCount(int itemId) {
    return _items[itemId]?.quantity ?? 1;
  }

  double get totalPrice => _totalPrice;

  void incrementCount(CartModel item) {
    if (_items.containsKey(item.hashCode)) {
      _items[item.hashCode]!.quantity++;
    } else {
      _items[item.hashCode] = item..quantity = 1;
    }
    item.save();
    _updateTotalPrice();
    notifyListeners();
  }

  void decrementCount(CartModel item) {
    if (_items.containsKey(item.hashCode) &&
        _items[item.hashCode]!.quantity > 1) {
      _items[item.hashCode]!.quantity--;
      item.save();
      _updateTotalPrice();
      notifyListeners();
    }
  }

  void deleteItem(CartModel item) {
    _items.remove(item.hashCode);
    item.delete();
    _updateTotalPrice();
    notifyListeners();
  }

  void _updateTotalPrice() {
    _totalPrice = 0.0;
    _items.forEach((key, item) {
      _totalPrice += item.priceAsDouble * item.quantity;
    });
  }


  Future<void> clearCart() async {
    _items.clear();
    var box = Boxes.getData();
    await box.clear();
    _updateTotalPrice();
    notifyListeners();
  }
}
