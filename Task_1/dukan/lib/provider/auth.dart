import 'package:dukan/screens/CartScreen/cart_model.dart';
import 'package:flutter/foundation.dart';

class PendingOrdersProvider extends ChangeNotifier {
  final List<CartModel> _pendingOrders = [];

  List<CartModel> get pendingOrders => _pendingOrders;

  void addPendingOrder(CartModel order) {
    _pendingOrders.add(order);
    notifyListeners();
  }
}
