import 'dart:convert';

import 'package:dukan/provider/ItemAdded.dart';

import 'package:dukan/Utilis/toast_message.dart';
import 'package:dukan/provider/cancelled.dart';
import 'package:dukan/provider/delivered.dart';
import 'package:dukan/provider/theme.dart';
import 'package:dukan/screens/CartScreen/box.dart';

import 'package:dukan/screens/CartScreen/cart_model.dart';
import 'package:dukan/strip/servicess/strip_services.dart';

import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';

class Cart_Screen extends StatefulWidget {
  const Cart_Screen({super.key});

  @override
  State<Cart_Screen> createState() => _Cart_ScreenState();
}

String currency = 'usd';
String amount = '5000';

class _Cart_ScreenState extends State<Cart_Screen> {
  void delete(CartModel cartmodel) {
    cartmodel.delete().then((value) {
      Utilis().ToastMessage('Item removed from cart');
    }).onError((error, stackTrace) {
      Utilis().ToastMessage(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final Iconprovider = Provider.of<ThemeChanger>(context);
    bool ISDark = Iconprovider.Thememode == ThemeMode.dark;

    return Scaffold(
      body: Consumer<ItemAdded>(
        builder: (context, itemAdded, child) {
          return Column(
            children: [
              Expanded(
                child: ValueListenableBuilder<Box<CartModel>>(
                  valueListenable: Boxes.getData().listenable(),
                  builder: (context, value, child) {
                    var data = value.values.toList().cast<CartModel>();

                    if (data.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('Assets/images/ni.webp', height: 301),
                            const Gap(11),
                            const Text('Your cart is empty',
                                style: TextStyle(
                                  fontSize: 24,
                                )),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var cartItem = data[index];

                        return Card(
                          shadowColor: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(11),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: _buildItemImage(cartItem),
                                  title: Text(cartItem.name.toString()),
                                  subtitle: Text(cartItem.price),
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
                                              child: const Text(
                                                '-',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 19),
                                              ),
                                            ),
                                            Text(
                                              '${cartItem.quantity}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 19),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                itemAdded
                                                    .incrementCount(cartItem);
                                              },
                                              child: const Text(
                                                '+',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 19),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Gap(11),
                                    Consumer<CanceledOrdersProvider>(
                                      builder: (context, val, child) {
                                        return IconButton(
                                          onPressed: () {
                                            itemAdded.deleteItem(cartItem);
                                            val.addCanceledOrder(cartItem);
                                          },
                                          icon: const Icon(Icons.delete),
                                        );
                                      },
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
                  var data = value.values.toList().cast<CartModel>();

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
                            Text('\$${itemAdded.totalPrice.toStringAsFixed(2)}',
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
                                        .then(
                                      (value) {},
                                    )
                                        .onError(
                                      (error, stackTrace) {
                                        Utilis().ToastMessage(error.toString());
                                      },
                                    );
                                    await StripServices.presentPaymentSheet()
                                        .then(
                                      (value) {
                                        Provider.of<DeliveredOrdersProvider>(
                                                context,
                                                listen: false)
                                            .addAllDeliveredOrders(data);
                                        val.clearCart();
                                        Utilis()
                                            .ToastMessage('payment successful');
                                      },
                                    ).onError(
                                      (error, stackTrace) {
                                        Utilis().ToastMessage(error.toString());
                                      },
                                    );
                                    print(
                                        'Payment process completed successfully');
                                  } catch (e, stackTrace) {
                                    print('Error in payment process: $e');
                                    print('Stack trace: $stackTrace');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  backgroundColor: ISDark
                                      ? Colors.deepPurple.shade300
                                      : Colors.black,
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                child: Text('Proceed to checkout',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: ISDark
                                            ? Colors.black
                                            : Colors.white,
                                        fontWeight: FontWeight.bold)));
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
      if (cartItem.image.startsWith('Assets/') ||
          cartItem.image.startsWith('assets/')) {
        // This is an asset image
        return Image.asset(cartItem.image,
            height: 71, width: 71, fit: BoxFit.cover);
      } else {
        // This is likely a file-based image (base64 encoded)
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