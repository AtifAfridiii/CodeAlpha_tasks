import 'package:dukan/components/cart.dart';
import 'package:dukan/screens/TabBar_screen/first_tab.dart';
import 'package:dukan/screens/product_details/Details.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Mens_Recommended extends StatefulWidget {
  const Mens_Recommended({super.key});

  @override
  State<Mens_Recommended> createState() => _Mens_RecommendedState();
}

class _Mens_RecommendedState extends State<Mens_Recommended> {
  final List<Cart_Item> recommended_items = [
    Cart_Item(
      title: 'Athleisure',
      subTitle: 99.9,
      UriImage: 'Products/images/img50.jpg',
    ),

    Cart_Item(
      title: 'Formal Attire',
      subTitle: 99.9,
      UriImage: 'Products/images/img51.jpg',
    ),

    Cart_Item(
      title: 'Weekend Casual',
      subTitle: 99.9,
      UriImage: 'Products/images/img52.jpg',
    ),
    Cart_Item(
      title: 'Bohemian',
      subTitle:99.9,
      UriImage: 'Products/images/img53.jpg',
    ),

    Cart_Item(
      title: 'Layered Looke',
      subTitle: 99.9,
      UriImage: 'Products/images/img54.jpg',
    ),

    Cart_Item(
      title: 'Preppy ',
      subTitle:99.9,
      UriImage: 'Products/images/img55.jpg',
    ),
    Cart_Item(
        UriImage: 'Products/images/img56.jpg',
        subTitle:99.9,
        title: 'Denim-on-Denim'),

    ///
    Cart_Item(
        UriImage: 'Products/images/img57.jpg',
        subTitle:99.9,
        title: 'Boho Chic'),

    Cart_Item(
        UriImage: 'Products/images/img58.jpg',
        subTitle: 99.9,
        title: 'Hipster '),

    Cart_Item(
        UriImage: 'Products/images/img59.jpg',
        subTitle: 99.9,
        title: 'Safari Style'),

    Cart_Item(
        UriImage: 'Products/images/img60.jpg',
        subTitle: 99.9,
        title: 'Minimalist'),

    Cart_Item(
        UriImage: 'Products/images/img61.jpg',
        subTitle: 99.9,
        title: 'Vacation Wear'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Recommended for you",
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
              itemCount: recommended_items.length,
              itemBuilder: (context, index) =>
                  buidcart(item: recommended_items[index]),
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
