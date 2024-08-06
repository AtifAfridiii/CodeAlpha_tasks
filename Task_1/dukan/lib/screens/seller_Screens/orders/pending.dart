import 'dart:convert';

import 'package:dukan/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pending_Order extends StatelessWidget {
  const Pending_Order({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PendingOrdersProvider>(
        builder: (context, pendingOrdersProvider, child) {
          if (pendingOrdersProvider.pendingOrders.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset(
                  'Assets/images/ser.png',
                )),
              ],
            );
          }
          return ListView.builder(
            itemCount: pendingOrdersProvider.pendingOrders.length,
            itemBuilder: (context, index) {
              final product = pendingOrdersProvider.pendingOrders[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: product.image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.memory(
                            base64Decode(product.image),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(Icons.image_not_supported),
                  title: Text(product.name),
                  subtitle: Text('Price: ${product.price}'),
                  trailing: const Text('Pending...',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
