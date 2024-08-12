import 'package:dukan/components/cart.dart';
import 'package:dukan/screens/TabBar_screen/first_tab.dart';
import 'package:dukan/screens/product_details/Details.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class MensShowall extends StatefulWidget {
  const MensShowall({super.key});

  @override
  State<MensShowall> createState() => _MensShowallState();
}

class _MensShowallState extends State<MensShowall> {
  final List<Cart_Item> items = [
    Cart_Item(
      title: 'Long coat',
      subTitle: 99.9,
      UriImage: 'Products/images/img6.jpg',
    ),

    Cart_Item(
      title: '3p suite',
      subTitle: 99.9,
      UriImage: 'Products/images/img25.jpg',
    ),

    Cart_Item(
      title: 'Stylish black',
      subTitle: 99.9,
      UriImage: 'Products/images/img17.jpg',
    ),
    Cart_Item(
      title: 'Hoddie',
      subTitle:99.9,
      UriImage: 'Products/images/img10.jpg',
    ),

    Cart_Item(
      title: 'V shape',
      subTitle: 99.9,
      UriImage: 'Products/images/img18.jpg',
    ),

    Cart_Item(
      title: 'Office ',
      subTitle: 99.9,
      UriImage: 'Products/images/img19.jpg',
    ),
    Cart_Item(
        UriImage: 'Products/images/img9.jpg',
        subTitle: 99.9,
        title: 'Thomas shelby'),

    ///
    Cart_Item(
        UriImage: 'Products/images/img15.jpg',
        subTitle: 99.9,
        title: 'Black'),

    Cart_Item(
        UriImage: 'Products/images/img3.jpg',
        subTitle: 99.9,
        title: 'Office '),

    Cart_Item(
        UriImage: 'Products/images/img4.jpg',
        subTitle: 99.9,
        title: 'Beggy shirt'),

    Cart_Item(
        UriImage: 'Products/images/img1.jpg',
        subTitle: 99.9,
        title: 'Casual outfit'),

    Cart_Item(
        UriImage: 'Products/images/img2.jpg',
        subTitle:  99.9,
        title: 'Gentle outfit'),
    Cart_Item(
        UriImage: 'Products/images/img5.jpg',
        subTitle: 99.9,
        title: 'Beggy outfit'),

    Cart_Item(
        UriImage: 'Products/images/img13.jpg',
        subTitle: 99.9,
        title: 'Trip outfit'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mens Store",
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
