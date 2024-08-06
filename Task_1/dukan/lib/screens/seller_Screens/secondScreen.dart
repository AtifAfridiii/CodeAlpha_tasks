import 'package:dukan/screens/CartScreen/box.dart';
import 'package:dukan/screens/CartScreen/cart_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:dukan/Utilis/toast_message.dart';

class LiveProduct extends StatefulWidget {
  const LiveProduct({super.key});

  @override
  State<LiveProduct> createState() => _LiveProductState();
}

class _LiveProductState extends State<LiveProduct> {
  late Box<AdModel> adBox;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('Ads');

  @override
  void initState() {
    super.initState();
    adBox = Boxes.getData2();
  }

  void _updateAd(String key, Map<dynamic, dynamic> ad) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController titleController =
            TextEditingController(text: ad['Title']);
        TextEditingController descriptionController =
            TextEditingController(text: ad['Description']);
        TextEditingController priceController =
            TextEditingController(text: ad['price'].toString());

        return AlertDialog(
          title: const Text('Update'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                  ),
                ),
                const Gap(11),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                    hintText: 'Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                  ),
                ),
                const Gap(11),
                TextFormField(
                  controller: descriptionController,
                  maxLength: 150,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _dbRef.child(key).update({
                  'Title': titleController.text,
                  'Description': descriptionController.text,
                  'price': priceController.text,
                });
                Navigator.of(context).pop();
                Utilis().ToastMessage('Item updated successfully');
              },
              child: const Text('Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _deleteAd(String key) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () {
              _dbRef.child(key).remove();
              Navigator.of(context).pop();
              Utilis().ToastMessage('Item deleted successfully');
            },
            child: const Text('Delete'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: _dbRef.onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data!.snapshot.value != null) {
                Map<dynamic, dynamic> values =
                    snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                List<MapEntry<dynamic, dynamic>> items =
                    values.entries.toList();

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final entry = items[index];
                    final ad = entry.value as Map<dynamic, dynamic>;

                    return Card(
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
                              'Price: ${ad['price'] ?? 'N/A'}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () => _updateAd(entry.key, ad),
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () => _deleteAd(entry.key),
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                ),
                              ],
                            )
                          ],
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
      ),
    );
  }
}
