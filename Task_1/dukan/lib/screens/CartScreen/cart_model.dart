import 'package:hive/hive.dart';
part 'cart_model.g.dart';

@HiveType(typeId: 0)
class CartModel extends HiveObject {
  @HiveField(0)
  String image;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String price;

  @HiveField(3)
  int quantity;

  CartModel({
    required this.image,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  double get priceAsDouble => double.tryParse(price) ?? 0.0;
}

@HiveType(typeId: 1)
class AdModel extends HiveObject {
  @HiveField(0)
  String Title;

  @HiveField(1)
  String Description;

  @HiveField(2)
  dynamic price;

  @HiveField(3)
  dynamic image;

  AdModel({
    required this.Title,
    required this.Description,
    required this.price,
    required this.image,
  });
}
