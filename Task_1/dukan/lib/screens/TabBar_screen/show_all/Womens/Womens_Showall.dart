import 'package:dukan/components/cart.dart';
import 'package:dukan/screens/TabBar_screen/first_tab.dart';
import 'package:dukan/screens/product_details/Details.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class WomenShowall extends StatefulWidget {
  const WomenShowall({super.key});

  @override
  State<WomenShowall> createState() => _WomenShowallState();
}

class _WomenShowallState extends State<WomenShowall> {
  final List<Cart_Item> items = [
    Cart_Item(
      title: ' Red shirt',
      subTitle: 99.9,
      UriImage: 'Cloths/images/img1.jpg',
    ),

    Cart_Item(
      title: 'Black shirt',
      subTitle: 99.9,
      UriImage: 'Cloths/images/img2.jpg',
    ),

    Cart_Item(
      title: 'Stylish ',
      subTitle: 99.9,
      UriImage: 'Cloths/images/img3.jpg',
    ),
    Cart_Item(
      title: 'Loan suites',
      subTitle: 99.9,
      UriImage: 'Cloths/images/img4.jpg',
    ),

    Cart_Item(
      title: 'Loan suite',
      subTitle: 99.9,
      UriImage: 'Cloths/images/img5.jpg',
    ),

    Cart_Item(
      title: 'jeans jacket ',
      subTitle: 99.9,
      UriImage: 'Cloths/images/img6.jpg',
    ),
    Cart_Item(
        UriImage: 'Cloths/images/img7.jpg',
        subTitle: 99.9,
        title: 'Sports '),

    ///
    Cart_Item(
        UriImage: 'Cloths/images/img8.jpg',
        subTitle: 99.9,
        title: 'Stylish'),

    Cart_Item(
        UriImage: 'Cloths/images/img9.jpg',
        subTitle: 99.9,
        title: 'Sports '),

    Cart_Item(
        UriImage: 'Cloths/images/img10.jpg',
        subTitle:99.9,
        title: 'Cotton'),

    Cart_Item(
        UriImage: 'Cloths/images/img11.jpg',
        subTitle: 99.9,
        title: 'Casual outfit'),

    Cart_Item(
        UriImage: 'Cloths/images/img12.jpg',
        subTitle: 99.9,
        title: '2p beggy '),
    Cart_Item(
        UriImage: 'Cloths/images/img13.jpg',
        subTitle: 99.9,
        title: 'casual outfit'),

    Cart_Item(
        UriImage: 'Cloths/images/img14.jpg',
        subTitle: 99.9,
        title: ' lorum outfit'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Women Store",
          style: GoogleFonts.b612(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: const EdgeInsets.all(10),
              itemCount: items.length,
              itemBuilder: (context, index) => buidcart(item: items[index]),
            ))
          ],
        ),
      ),
    );
  }

  Widget buidcart({
    required Cart_Item item,
  }) {
    return SizedBox(
      height: 201,
      child: Column(
        children: [
          Expanded(
              child: AspectRatio(
            aspectRatio: 4 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Material(
                child: Ink.image(
                  image: AssetImage(item.UriImage),
                  fit: BoxFit.cover,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details(
                              image: item.UriImage,
                              price: item.subTitle,
                              name: item.title,
                              description: des,
                            ),
                          ));
                    },
                  ),
                ),
              ),
            ),
          )),
          const Gap(5),
          Text(
            item.title,
            style: GoogleFonts.b612(fontWeight: FontWeight.bold),
          ),
          Text(
            item.subTitle.toStringAsFixed(2),
            style: GoogleFonts.b612(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
