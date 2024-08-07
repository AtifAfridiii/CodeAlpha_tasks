import 'dart:convert'; // Import for base64 decoding
import 'dart:typed_data'; // Import for Uint8List

import 'package:dukan/provider/auth.dart';
import 'package:dukan/provider/theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import 'package:dukan/Utilis/toast_message.dart';
import 'package:dukan/provider/iconColor.dart';
import 'package:dukan/provider/product_color.dart';
import 'package:dukan/screens/CartScreen/box.dart';
import 'package:dukan/screens/CartScreen/cart_model.dart';

class Details extends StatefulWidget {
  final dynamic image;
  final String name;
  final dynamic price;
  final String description;

  const Details({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isItemAdded = false;
  Uint8List? decodedImage;
  bool isAssetImage = false;

  @override
  void initState() {
    super.initState();
    checkIfItemAlreadyInCart();
    decodeImage();
  }

  void checkIfItemAlreadyInCart() async {
    final box = Boxes.getData();
    final items = box.values.toList();
    for (var item in items) {
      if (item.name == widget.name &&
          item.price == widget.price &&
          item.image == widget.image) {
        setState(() {
          isItemAdded = true;
        });
        return;
      }
    }
  }

  void decodeImage() {
    if (widget.image != null) {
      try {
        decodedImage = base64Decode(widget.image);
        isAssetImage = false;
      } catch (e) {
        isAssetImage = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Iconprovider = Provider.of<ThemeChanger>(context);
    bool ISDark = Iconprovider.Thememode == ThemeMode.dark;
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!isAssetImage && decodedImage != null)
              Image.memory(
                decodedImage!,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 300,
              )
            else if (isAssetImage && widget.image != null)
              Image.asset(
                widget.image,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 300,
              ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(82, 254, 254, 254),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 1,
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Gap(5),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${widget.price}',
                            style: GoogleFonts.b612(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(5),
                    Star(),
                    const Gap(11),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Color',
                              style: GoogleFonts.b612(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          Text('Size',
                              style: GoogleFonts.b612(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Gap(21),
                        buildColorButton(0, Colors.orange),
                        const Gap(11),
                        buildColorButton(1, Colors.red),
                        const Gap(11),
                        buildColorButton(2, Colors.brown),
                        const Gap(121),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildSizeButton(0, 'S'),
                            const Gap(11),
                            buildSizeButton(1, 'M'),
                            const Gap(11),
                            buildSizeButton(2, 'L'),
                          ],
                        )
                      ],
                    ),
                    const Gap(21),
                    ExpansionPanelList.radio(
                      children: [
                        ExpansionPanelRadio(
                          value: 0,
                          headerBuilder: (context, isExpanded) {
                            return const ListTile(
                              title: Text('Description'),
                            );
                          },
                          body: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 11, vertical: 11),
                            child: ReadMoreText(
                              widget.description,
                              style: GoogleFonts.aBeeZee(),
                              trimLines: 2,
                              trimMode: TrimMode.Line,
                              colorClickableText: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(11),
                    ExpansionPanelList.radio(
                      children: [
                        ExpansionPanelRadio(
                          value: 1,
                          headerBuilder: (context, isExpanded) {
                            return const ListTile(
                              title: Text('Reviews'),
                            );
                          },
                          body: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  child: Image.asset('Assets/images/prof.png'),
                                ),
                                title: const Text('John wick'),
                                trailing: const Text('11m ago'),
                                subtitle: const Text('Amazing product'),
                              ),
                              ListTile(
                                leading: CircleAvatar(
                                  child: Image.asset('Assets/images/prof.png'),
                                ),
                                title: const Text('Kai'),
                                trailing: const Text('15m ago'),
                                subtitle: const Text('Outstanding'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: ISDark ? Colors.deepPurple : Colors.black,
              borderRadius: BorderRadius.circular(15),
            ),
            child: isItemAdded
                ? const Text(
                    'Item already added to cart',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  )
                : Consumer<PendingOrdersProvider>(
                    builder: (context, val, child) {
                      return ElevatedButton.icon(
  onPressed: () {
   
    final data = {
      'image': base64Encode(decodedImage!), 
      'name': widget.name,
      'price': widget.price,
      'status': 'Pending'
    };

    
    final DatabaseReference _database = FirebaseDatabase.instance.ref().child('pending_orders');
    
    _database.push().set(data).then((_) {
     
    }).catchError((error) {
      Utilis().ToastMessage(error.toString());
    });

   
    final cartData = CartModel(
      image: widget.image,
      name: widget.name,
      price: widget.price,
    );

    final box = Boxes.getData();
    box.add(cartData).then((value) {
      Utilis().ToastMessage('Item added');
      val.addPendingOrder(cartData); 
    }).onError((error, stackTrace) {
      Utilis().ToastMessage(error.toString());
    });

    cartData.save(); 
  },
  style: ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: ISDark ? Colors.deepPurple : Colors.black,
    minimumSize: const Size(double.infinity, 50),
  ),
  icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
  label: const Text('Add To Cart', style: TextStyle(fontSize: 16)),
);
                    },
                  )),
      ),
    );
  }

  Widget buildColorButton(int index, Color color) {
    return Consumer<ProductColor>(
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            value.setColorIndex(index);
          },
          child: product_Color(
            color,
            value.SelectedColorIndex == index ? 65.0 : 51.0,
            value.SelectedColorIndex == index ? 31.0 : 21.0,
            '',
          ),
        );
      },
    );
  }

  Widget buildSizeButton(int index, String title) {
    return Consumer<ProductColor>(
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            value.setSizedIndex(index);
          },
          child: product_Color(
            value.SelectedSizedIndex == index ? Colors.black45 : Colors.black12,
            65.0,
            31,
            title,
          ),
        );
      },
    );
  }

  Widget Star() {
    return SizedBox(
      height: 41,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer<Iconcolor>(
              builder: (context, value, child) {
                return IconButton(
                  onPressed: () {
                    value.seticonCOlor4();
                  },
                  icon: Icon(
                    value.iconColor4 ? Icons.star : Icons.star_border_outlined,
                    size: 29,
                    color: Colors.green,
                  ),
                );
              },
            ),
            Consumer<Iconcolor>(
              builder: (context, value, child) {
                return IconButton(
                  onPressed: () {
                    value.seticonCOlor1();
                  },
                  icon: Icon(
                    value.iconColor1 ? Icons.star : Icons.star_border_outlined,
                    size: 29,
                    color: Colors.green,
                  ),
                );
              },
            ),
            Consumer<Iconcolor>(
              builder: (context, value, child) {
                return IconButton(
                  onPressed: () {
                    value.seticonCOlor2();
                  },
                  icon: Icon(
                    value.iconColor2 ? Icons.star : Icons.star_border_outlined,
                    size: 29,
                    color: Colors.green,
                  ),
                );
              },
            ),
            Consumer<Iconcolor>(
              builder: (context, value, child) {
                return IconButton(
                  onPressed: () {
                    value.seticonCOlor3();
                  },
                  icon: Icon(
                    value.iconColor3 ? Icons.star : Icons.star_border_outlined,
                    size: 29,
                    color: Colors.green,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget product_Color(
      Color productColor, double height, double width, String title) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: productColor,
        shape: BoxShape.circle,
        border: Border.all(
          width: 3,
          color: Colors.white70,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 3,
            blurStyle: BlurStyle.outer,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Center(child: Text(title)),
    );
  }
}
