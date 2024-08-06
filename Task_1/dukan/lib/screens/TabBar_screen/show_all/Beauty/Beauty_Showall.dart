import 'package:dukan/components/cart.dart';
import 'package:dukan/screens/TabBar_screen/first_tab.dart';
import 'package:dukan/screens/product_details/Details.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class BeautyShowall extends StatefulWidget {
  const BeautyShowall({super.key});

  @override
  State<BeautyShowall> createState() => _BeautyShowallState();
}

class _BeautyShowallState extends State<BeautyShowall> {
  final List<Cart_Item> items = [
    Cart_Item(
      title: 'MAC Cosmetics',
      subTitle: 'Rs 99.9',
      UriImage: 'Beauty/images/img1.jpg',
    ),

    Cart_Item(
      title: 'Estée Lauder',
      subTitle: "Rs 599.0",
      UriImage: 'Beauty/images/img2.jpg',
    ),

    Cart_Item(
      title: 'Maybelline',
      subTitle: 'Rs 549.0',
      UriImage: 'Beauty/images/img3.jpg',
    ),
    Cart_Item(
      title: 'NARS',
      subTitle: 'Rs 99.9',
      UriImage: 'Beauty/images/img4.jpg',
    ),

    Cart_Item(
      title: 'Urban Decay',
      subTitle: "Rs 99.9",
      UriImage: 'Beauty/images/img5.jpg',
    ),

    Cart_Item(
      title: 'Benefit Cosmetics ',
      subTitle: 'Rs 549.0',
      UriImage: 'Beauty/images/img6.jpg',
    ),
    Cart_Item(
        UriImage: 'Beauty/images/img7.jpg',
        subTitle: 'Rs 109',
        title: 'Too Faced'),

    ///
    Cart_Item(
        UriImage: 'Beauty/images/img8.jpg',
        subTitle: 'Rs 200',
        title: 'Charlotte Tilbury'),

    Cart_Item(
        UriImage: 'Beauty/images/img9.jpg',
        subTitle: 'Rs 901',
        title: 'Anastasia Beverly Hills '),

    Cart_Item(
        UriImage: 'Beauty/images/img10.jpg',
        subTitle: 'Rs 501',
        title: 'Huda Beauty'),

    Cart_Item(
        UriImage: 'Beauty/images/img11.jpg',
        subTitle: 'Rs 501',
        title: 'Tarte Cosmetics'),

    Cart_Item(
        UriImage: 'Beauty/images/img12.jpg',
        subTitle: 'Rs 501',
        title: 'Laura Mercier'),
    Cart_Item(
        UriImage: 'Beauty/images/img13.jpg',
        subTitle: 'Rs 501',
        title: 'Smashbox'),

    Cart_Item(
        UriImage: 'Beauty/images/img15.jpg',
        subTitle: 'Rs 501',
        title: 'Glossier'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Beauty Products",
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
            item.subTitle,
            style: GoogleFonts.b612(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
