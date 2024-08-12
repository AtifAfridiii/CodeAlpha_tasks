import 'package:dukan/components/cart.dart';
import 'package:dukan/screens/TabBar_screen/first_tab.dart';
import 'package:dukan/screens/product_details/Details.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class AccessShowall extends StatefulWidget {
  const AccessShowall({super.key});

  @override
  State<AccessShowall> createState() => _AccessShowallState();
}

class _AccessShowallState extends State<AccessShowall> {
  final List<Cart_Item> items = [
    Cart_Item(
      title: 'Bridal crown',
      subTitle: 99.9,
      UriImage: 'access/images/img1.jpg',
    ),

    Cart_Item(
      title: 'Couple rings',
      subTitle: 99.9,
      UriImage: 'access/images/img2.jpg',
    ),

    Cart_Item(
      title: 'Ear rings',
      subTitle: 99.9,
      UriImage: 'access/images/img3.jpg',
    ),
    Cart_Item(
      title: 'Mens watch',
      subTitle:99.9,
      UriImage: 'access/images/img4.jpg',
    ),

    Cart_Item(
      title: 'Louis Vuitton',
      subTitle:99.9,
      UriImage: 'access/images/img5.jpg',
    ),

    Cart_Item(
      title: 'Mens Ring ',
      subTitle: 99.9,
      UriImage: 'access/images/img6.jpg',
    ),
    Cart_Item(
        UriImage: 'access/images/img7.jpg',
        subTitle: 99.9,
        title: 'Pearl necklace'),

    ///
    Cart_Item(
        UriImage: 'access/images/img8.jpg',
        subTitle: 99.9,
        title: 'Ruby necklace'),

    Cart_Item(
        UriImage: 'access/images/img9.jpg',
        subTitle: 99.9,
        title: 'Mini speakers '),

    Cart_Item(
        UriImage: 'access/images/img10.jpg',
        subTitle: 99.9,
        title: 'Zara bag'),

    Cart_Item(
        UriImage: 'access/images/img11.jpg',
        subTitle:99.9,
        title: 'Gold chains'),

    Cart_Item(
        UriImage: 'access/images/img12.jpg',
        subTitle: 99.9,
        title: 'Diamond ring'),
    Cart_Item(
        UriImage: 'access/images/img13.jpg',
        subTitle: 99.9,
        title: 'Goggels'),

    Cart_Item(
        UriImage: 'access/images/img14.jpg',
        subTitle: 99.9,
        title: 'Gold rings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Accessiors",
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
