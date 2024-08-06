import 'package:dukan/screens/CartScreen/cart_model.dart';
import 'package:flutter/material.dart';

class CanceledOrdersProvider extends ChangeNotifier {
  final List<CartModel> _canceledOrders = [];
  List<CartModel> get canceledOrders => _canceledOrders;

  void addCanceledOrder(CartModel order) {
    _canceledOrders.add(order);
    notifyListeners();
  }
}
