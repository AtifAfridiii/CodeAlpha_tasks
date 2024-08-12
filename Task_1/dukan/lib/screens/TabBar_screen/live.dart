import 'dart:convert';

import 'package:dukan/screens/product_details/Details.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:dukan/screens/CartScreen/box.dart';
import 'package:dukan/screens/CartScreen/cart_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FifthScreen extends StatefulWidget {
  const FifthScreen({super.key});

  @override
  State<FifthScreen> createState() => _FifthScreenState();
}

class _FifthScreenState extends State<FifthScreen> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('Ads');
  late Box<AdModel> adBox;

  @override
  void initState() {
    super.initState();
    adBox = Boxes.getData2();
  }

  double parsePrice(dynamic price) {
    if (price is int) {
      return price.toDouble();
    } else if (price is double) {
      return price;
    } else if (price is String) {
      return double.tryParse(price) ?? 0.0;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: _dbRef.onValue,
          builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData &&
                !snapshot.hasError &&
                snapshot.data!.snapshot.value != null) {
              Map<dynamic, dynamic> values =
                  snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
              List<MapEntry<dynamic, dynamic>> items = values.entries.toList();

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final entry = items[index];
                  final ad = entry.value as Map<dynamic, dynamic>;
                final double price = parsePrice(ad['price']);

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details(
                                image: ad['image'],
                                name: ad['Title'],
                               price: price,
                                description: ad['Description']),
                          ));
                    },
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (ad['image'] != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(19),
                                child: Image.memory(
                                  base64Decode(ad['image']),
                                  fit: BoxFit.cover,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width: double.infinity,
                                ),
                              ),
                            const Gap(10),
                            Text(
                              ad['Title'] ?? 'No Title',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(5),
                            Text(ad['Description'] ?? 'No Description'),
                            const Gap(5),
                           Text(
                            'Price: ${price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                            const Gap(10),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Image.asset('Assets/images/not.webp')),
                  const Gap(11),
                  const Center(child: Text('No items found')),
                ],
              );
            }
          }),
    );
  }
}
