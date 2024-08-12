import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:dukan/provider/ItemAdded.dart';
import 'package:dukan/Utilis/toast_message.dart';
import 'package:dukan/provider/theme.dart';
import 'package:dukan/screens/CartScreen/box.dart';
import 'package:dukan/screens/CartScreen/cart_model.dart';
import 'package:dukan/strip/servicess/strip_services.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Cart_Screen extends StatefulWidget {
  const Cart_Screen({super.key});

  @override
  State<Cart_Screen> createState() => _Cart_ScreenState();
}

class _Cart_ScreenState extends State<Cart_Screen> {
   final DatabaseReference _database = FirebaseDatabase.instance.ref();

  void delete(CartModel cartModel) {
    cartModel.delete().then((value) {
      Utilis().ToastMessage('Item removed from cart');
      _database.child('canceled_orders').push().set({
        'name': cartModel.name,
        'price': cartModel.price, 
        'quantity': cartModel.quantity,
        'image': cartModel.image,
        'timestamp': ServerValue.timestamp,
      });
     Provider.of<ItemAdded>(context, listen: false).deleteItem(cartModel);
    }).onError((error, stackTrace) {
      // Utilis().ToastMessage(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final iconProvider = Provider.of<ThemeChanger>(context);
    bool isDark = iconProvider.Thememode == ThemeMode.dark;

    return Scaffold(
      body: Consumer<ItemAdded>(
        builder: (context, itemAdded, child) {
          return Column(
            children: [
              Expanded(
                child: ValueListenableBuilder<Box<CartModel>>(
                  valueListenable: Boxes.getData().listenable(),
                  builder: (context, value, child) {
                    dynamic data = value.values.toList().cast<CartModel>();

                    if (data.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('Assets/images/ni.webp', height: 301),
                            const Gap(11),
                            const Text('Your cart is empty',
                                style: TextStyle(fontSize: 24)),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        dynamic cartItem = data[index];
                       
                        return Card(
                          shadowColor: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(11),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: _buildItemImage(cartItem),
                                  title: Text(cartItem.name.toString()),
                                  subtitle: Text( cartItem.price.toStringAsFixed(2),),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 21,
                                      width: 71,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(21),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black,
                                            blurRadius:
                                                BorderSide.strokeAlignOutside,
                                            blurStyle: BlurStyle.outer,
                                            spreadRadius: 3,
                                          )
                                        ],
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                itemAdded
                                                    .decrementCount(cartItem);
                                              },
                                              child: const Text('-',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 19)),
                                            ),
                                            Text('${cartItem.quantity}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 19)),
                                            GestureDetector(
                                              onTap: () {
                                                itemAdded
                                                    .incrementCount(cartItem);
                                              },
                                              child: const Text('+',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 19)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Gap(11),
                                    IconButton(
                                      onPressed: () {
                                        delete(cartItem);
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              ValueListenableBuilder<Box<CartModel>>(
                valueListenable: Boxes.getData().listenable(),
                builder: (context, value, child) {
                  dynamic data = value.values.toList().cast<CartModel>();

                  if (data.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Shipping',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey)),
                            Text('Freeship',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Gap(21),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Subtotal',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text('\$${data.fold(0, (sum, item) => sum + item.price * item.quantity).toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Consumer<ItemAdded>(
                          builder: (context, val, child) {
                            return ElevatedButton(
                              onPressed: () async {
                                try {
                                  print('Payment button pressed');
                                  await StripServices.initPaymentSheet(
                                          '100', 'USD')
                                      .then((value) {})
                                      .onError((error, stackTrace) {
                                    Utilis().ToastMessage(error.toString());
                                  });
                                  await StripServices.presentPaymentSheet()
                                      .then((value) {
                                    for (var item in data) {
                                      _database
                                          .child('delivered_orders')
                                          .push()
                                          .set({
                                        'name': item.name,
                                        'price': item.price,
                                        'quantity': item.quantity,
                                        'image': item.image,
                                        'timestamp': ServerValue.timestamp,
                                      });
                                    }
                                    val.clearCart();
                                    Utilis().ToastMessage('Payment successful');
                                  }).onError((error, stackTrace) {
                                    Utilis().ToastMessage(error.toString());
                                  });
                                  print(
                                      'Payment process completed successfully');
                                } catch (e, stackTrace) {
                                  print('Error in payment process: $e');
                                  print('Stack trace: $stackTrace');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                backgroundColor: isDark
                                    ? Colors.deepPurple.shade300
                                    : Colors.black,
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: Text('Proceed to checkout',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          isDark ? Colors.black : Colors.white,
                                      fontWeight: FontWeight.bold)),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildItemImage(CartModel cartItem) {
  try {
    if (cartItem.image.startsWith('Assets/') || cartItem.image.startsWith('assets/')) {
      String imagePath = cartItem.image.replaceFirst('Assets/', 'assets/'); // remove 'Assets/' prefix
      imagePath = imagePath.replaceFirst('assets/', 'assets/'); // remove 'assets/' prefix
      return Image.asset(imagePath, height: 71, width: 71, fit: BoxFit.cover);
    } else {
      return Image.memory(
        base64Decode(cartItem.image),
        height: 71,
        width: 71,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading image: $error');
          return const Icon(Icons.image_not_supported, size: 71);
        },
      );
    }
  } catch (e) {
    print('Error displaying image: $e');
    return const Icon(Icons.image_not_supported, size: 71);
  }
}
}
