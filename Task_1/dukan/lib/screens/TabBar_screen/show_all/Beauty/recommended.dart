import 'package:dukan/components/cart.dart';
import 'package:dukan/screens/TabBar_screen/first_tab.dart';
import 'package:dukan/screens/product_details/Details.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Beauty_Recommended extends StatefulWidget {
  const Beauty_Recommended({super.key});

  @override
  State<Beauty_Recommended> createState() => _Beauty_RecommendedState();
}

class _Beauty_RecommendedState extends State<Beauty_Recommended> {
  final List<Cart_Item> recommended_items = [
    Cart_Item(
      title: 'Milk Makeup',
      subTitle: 'Rs 99.9',
      UriImage: 'Beauty/images/img50.jpg',
    ),

    Cart_Item(
      title: 'Ilia Beauty',
      subTitle: "Rs 599.0",
      UriImage: 'Beauty/images/img51.jpg',
    ),

    Cart_Item(
      title: 'BareMinerals',
      subTitle: 'Rs 549.0',
      UriImage: 'Beauty/images/img52.jpg',
    ),
    Cart_Item(
      title: 'Shiseido',
      subTitle: 'Rs 99.9',
      UriImage: 'Beauty/images/img53.jpg',
    ),

    Cart_Item(
      title: 'Bite Beauty',
      subTitle: "Rs 99.9",
      UriImage: 'Beauty/images/img15.jpg',
    ),

    Cart_Item(
      title: 'Surratt Beauty ',
      subTitle: 'Rs 549.0',
      UriImage: 'Beauty/images/img55.jpg',
    ),
    Cart_Item(
        UriImage: 'Beauty/images/img56.jpg',
        subTitle: 'Rs 109',
        title: 'Beautycounter'),

    ///
    Cart_Item(
        UriImage: 'Beauty/images/img57.jpg',
        subTitle: 'Rs 200',
        title: 'Tatcha'),

    Cart_Item(
        UriImage: 'Beauty/images/img58.jpg',
        subTitle: 'Rs 901',
        title: 'Viseart '),

    Cart_Item(
        UriImage: 'Beauty/images/img59.jpg',
        subTitle: 'Rs 501',
        title: 'Vichy'),

    Cart_Item(
        UriImage: 'Beauty/images/img60.jpg',
        subTitle: 'Rs 501',
        title: 'Clarins'),

    Cart_Item(
        UriImage: 'Beauty/images/img61.jpg',
        subTitle: 'Rs 501',
        title: 'Farsali'),
    Cart_Item(
        UriImage: 'Beauty/images/img62.jpg',
        subTitle: 'Rs 501',
        title: 'Rituel de Fille'),
    Cart_Item(
        UriImage: 'Beauty/images/img63.jpg',
        subTitle: 'Rs 501',
        title: 'Caudalie'),
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
