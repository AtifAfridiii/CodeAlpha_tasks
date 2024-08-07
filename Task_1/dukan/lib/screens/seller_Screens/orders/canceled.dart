import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Canceled_Order extends StatelessWidget {
 const Canceled_Order({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    final DatabaseReference _database = FirebaseDatabase.instance.ref().child('canceled_orders');
    return Scaffold(
      body: StreamBuilder(
        stream: _database.onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            Map<dynamic, dynamic> orders = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
            List<Map<dynamic, dynamic>> orderList = [];
            orders.forEach((key, value) {
              orderList.add(value);
            });

            if (orderList.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Image.asset('Assets/images/ser.png')),
                ],
              );
            }

            return ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (context, index) {
                var order = orderList[index];
                return Card(
                  child: ListTile(
                    leading: order['image'] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.memory(
                              base64Decode(order['image']),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.image_not_supported),
                    title: Text(order['name']),
                    subtitle: Text('Price: ${order['price']}'),
                    trailing: Text('Quantity: ${order['quantity']}'),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}