import 'package:dukan/screens/CartScreen/cart_model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<CartModel> getData() => Hive.box<CartModel>('Cart');
  static Box<AdModel> getData2() => Hive.box<AdModel>('Ad');
}
