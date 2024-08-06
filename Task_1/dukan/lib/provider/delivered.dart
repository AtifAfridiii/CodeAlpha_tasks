import 'package:dukan/screens/CartScreen/cart_model.dart';
import 'package:flutter/material.dart';

class DeliveredOrdersProvider extends ChangeNotifier {
  final List<CartModel> _deliveredOrders = [];
  List<CartModel> get deliveredOrders => _deliveredOrders;

  void addDeliveredOrder(CartModel order) {
    _deliveredOrders.add(order);
    notifyListeners();
  }

  void addAllDeliveredOrders(List<CartModel> orders) {
    _deliveredOrders.addAll(orders);
    notifyListeners();
  }
}
