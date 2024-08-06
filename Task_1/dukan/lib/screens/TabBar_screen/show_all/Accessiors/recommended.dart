import 'package:dukan/components/cart.dart';
import 'package:dukan/screens/TabBar_screen/first_tab.dart';
import 'package:dukan/screens/product_details/Details.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Access_Recommended extends StatefulWidget {
  const Access_Recommended({super.key});

  @override
  State<Access_Recommended> createState() => _Access_RecommendedState();
}

class _Access_RecommendedState extends State<Access_Recommended> {
  final List<Cart_Item> recommended_items = [
    Cart_Item(
      title: 'Pearl ring',
      subTitle: 'Rs 99.9',
      UriImage: 'access/images/img28.jpg',
    ),

    Cart_Item(
      title: 'Birthstone Ring',
      subTitle: "Rs 599.0",
      UriImage: 'access/images/img15.jpg',
    ),

    Cart_Item(
      title: 'Peach glasses',
      subTitle: 'Rs 549.0',
      UriImage: 'access/images/img16.jpg',
    ),
    Cart_Item(
      title: 'Women rings',
      subTitle: 'Rs 99.9',
      UriImage: 'access/images/img17.jpg',
    ),

    Cart_Item(
      title: 'Braclets',
      subTitle: "Rs 99.9",
      UriImage: 'access/images/img18.jpg',
    ),

    Cart_Item(
      title: 'Zara bag ',
      subTitle: 'Rs 549.0',
      UriImage: 'access/images/img19.jpg',
    ),
    Cart_Item(
        UriImage: 'access/images/img20.jpg',
        subTitle: 'Rs 109',
        title: 'Remember me '),

    ///
    Cart_Item(
        UriImage: 'access/images/img21.jpg',
        subTitle: 'Rs 200',
        title: 'Diamonds'),

    Cart_Item(
        UriImage: 'access/images/img22.jpg',
        subTitle: 'Rs 901',
        title: 'Eternity Ring '),

    Cart_Item(
        UriImage: 'access/images/img23.jpg',
        subTitle: 'Rs 501',
        title: 'Cocktail Ring'),

    Cart_Item(
        UriImage: 'access/images/img24.jpg',
        subTitle: 'Rs 501',
        title: 'Halo Ring'),

    Cart_Item(
        UriImage: 'access/images/img25.jpg',
        subTitle: 'Rs 501',
        title: 'Head phones'),
    Cart_Item(
        UriImage: 'access/images/img26.jpg', subTitle: 'Rs 501', title: 'H&M'),
    Cart_Item(
        UriImage: 'access/images/img27.jpg',
        subTitle: 'Rs 501',
        title: 'Mens watch'),
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
            item.subTitle,
            style: GoogleFonts.b612(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
