import 'package:hive/hive.dart';
part 'cart_model.g.dart';

@HiveType(typeId: 0)
class CartModel extends HiveObject {
  @HiveField(0)
  String image;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  @HiveField(3)
  int quantity;

  CartModel({
    required this.image,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  double get priceAsDouble => price;
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      image: json['image'] as String,
      name: json['name'] as String,
      price: _parseDouble(json['price']),
      quantity: json['quantity'] as int? ?? 1,
    );
  }

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.parse(value);
    throw FormatException('Cannot parse $value to double');
  }
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
