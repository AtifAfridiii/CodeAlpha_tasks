import 'dart:convert';

import 'package:dukan/provider/cancelled.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Canceled_Order extends StatelessWidget {
  const Canceled_Order({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CanceledOrdersProvider>(
        builder: (context, canceledOrdersProvider, child) {
          if (canceledOrdersProvider.canceledOrders.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Image.asset('Assets/images/ser.png')),
              ],
            );
          }
          return ListView.builder(
            itemCount: canceledOrdersProvider.canceledOrders.length,
            itemBuilder: (context, index) {
              var order = canceledOrdersProvider.canceledOrders[index];
              return Card(
                child: ListTile(
                  leading: order.image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.memory(
                            base64Decode(order.image),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(Icons.image_not_supported),
                  title: Text(order.name),
                  subtitle: Text('Price: ${order.price}'),
                  trailing: Text('Quantity: ${order.quantity}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
