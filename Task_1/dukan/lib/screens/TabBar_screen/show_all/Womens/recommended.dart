import 'package:dukan/components/cart.dart';
import 'package:dukan/screens/TabBar_screen/first_tab.dart';
import 'package:dukan/screens/product_details/Details.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Women_Recommended extends StatefulWidget {
  const Women_Recommended({super.key});

  @override
  State<Women_Recommended> createState() => _Women_RecommendedState();
}

class _Women_RecommendedState extends State<Women_Recommended> {
  final List<Cart_Item> recommended_items = [
    Cart_Item(
      title: 'Hat & Bag',
      subTitle: 'Rs 99.9',
      UriImage: 'Cloths/images/img50.jpg',
    ),

    Cart_Item(
      title: 'Women Sweater',
      subTitle: "Rs 599.0",
      UriImage: 'Cloths/images/img51.jpg',
    ),

    Cart_Item(
      title: 'Shirts',
      subTitle: 'Rs 549.0',
      UriImage: 'Cloths/images/img52.jpg',
    ),
    Cart_Item(
      title: 'Japanese outfit',
      subTitle: 'Rs 99.9',
      UriImage: 'Cloths/images/img53.jpg',
    ),

    Cart_Item(
      title: 'Ezi',
      subTitle: "Rs 99.9",
      UriImage: 'Cloths/images/img54.jpg',
    ),

    Cart_Item(
      title: 'Office ',
      subTitle: 'Rs 549.0',
      UriImage: 'Cloths/images/img55.jpg',
    ),
    Cart_Item(
        UriImage: 'Cloths/images/img56.jpg',
        subTitle: 'Rs 109',
        title: 'Casual'),

    ///
    Cart_Item(
        UriImage: 'Cloths/images/img57.jpg',
        subTitle: 'Rs 200',
        title: 'Beggy'),

    Cart_Item(
        UriImage: 'Cloths/images/img58.jpg',
        subTitle: 'Rs 901',
        title: 'Office '),

    Cart_Item(
        UriImage: 'Cloths/images/img59.jpg',
        subTitle: 'Rs 501',
        title: 'Ezi outfit'),

    Cart_Item(
        UriImage: 'Cloths/images/img60.jpg',
        subTitle: 'Rs 501',
        title: 'Casual outfit'),

    Cart_Item(
        UriImage: 'Cloths/images/img61.jpg',
        subTitle: 'Rs 501',
        title: 'Ezi outfit'),
    Cart_Item(
        UriImage: 'Cloths/images/img62.jpg',
        subTitle: 'Rs 501',
        title: 'Ralph Lauren'),
    Cart_Item(
        UriImage: 'Cloths/images/img63.jpg',
        subTitle: 'Rs 501',
        title: 'Chanel'),
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
