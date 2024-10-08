import 'package:dukan/components/cart.dart';
import 'package:dukan/screens/TabBar_screen/show_all/Beauty/Beauty_Showall.dart';
import 'package:dukan/screens/TabBar_screen/show_all/Beauty/recommended.dart';
import 'package:dukan/screens/product_details/Details.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dukan/provider/Page_Indicator.dart';

class FourthTabContent extends StatefulWidget {
  const FourthTabContent({super.key});

  @override
  State<FourthTabContent> createState() => _FourthTabContentState();
}

String des =
    'Stay warm and stylish with our premium long coat, designed to provide exceptional coverage and comfort. Made from high-quality materials, this coat extends below the knees and features a tailored fit for a sleek and elegant look. Perfect for any occasion, whether youre dressing up for a formal event or adding sophistication to your everyday outfit. Dont miss out on this timeless addition to your wardrobe—order now and embrace the ultimate blend of fashion and functionality!';

class _FourthTabContentState extends State<FourthTabContent> {
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final Urlimage = [
      'Beauty/images/img1.jpg',
      'Beauty/images/img2.jpg',
      'Beauty/images/img3.jpg',
      'Beauty/images/img4.jpg',
      'Beauty/images/img5.jpg',
    ];

    final List<Cart_Item> items = [
      Cart_Item(
        title: 'LipZ sticks',
        subTitle: 111,
        UriImage: 'Beauty/images/img6.jpg',
      ),
      Cart_Item(
        title: 'Beauty seriums  ',
        subTitle: 99.9,
        UriImage: 'Beauty/images/img7.jpg',
      ),
      Cart_Item(
        title: 'Avon kit',
        subTitle: 225,
        UriImage: 'Beauty/images/img8.jpg',
      ),
    ];

    final List<Cart_Item> recomended = [
      Cart_Item(
        title: 'Laura Mercier',
        subTitle:99.9,
        UriImage: 'Beauty/images/img53.jpg',
      ),
      Cart_Item(
        title: 'Pat McGrath Labs',
        subTitle: 99.9,
        UriImage: 'Beauty/images/img57.jpg',
      ),
      Cart_Item(
        title: 'Serium',
        subTitle: 99.9,
        UriImage: 'Beauty/images/img61.jpg',
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          const Gap(11),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.5,
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: Consumer<Smooth_Page>(
              builder: (context, val, child) {
                return CarouselSlider.builder(
                  itemCount: Urlimage.length,
                  itemBuilder: (context, index, realIndex) {
                    final url = Urlimage[index];
                    return buildimage(url, index);
                  },
                  options: CarouselOptions(
                    initialPage: val.InitialPage,
                    height: 401,
                    autoPlayCurve: Curves.linear,
                    enableInfiniteScroll: true,
                    scrollDirection: Axis.horizontal,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    animateToClosest: true,
                    disableCenter: true,
                    enlargeFactor: 0.3,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                    pauseAutoPlayOnTouch: true,
                    onPageChanged: (index, reason) {
                      val.setPage(index);
                    },
                  ),
                );
              },
            ),
          ),
          const Gap(7),
          Consumer<Smooth_Page>(
            builder: (context, pageProvider, child) {
              return buildindicator(pageProvider, Urlimage.length);
            },
          ),
          const Gap(21),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Feature Products',
                  style: GoogleFonts.b612(
                      fontSize: 19, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BeautyShowall(),
                          ));
                    },
                    child: const Text(
                      'Show all',
                      style: TextStyle(),
                    ))
              ],
            ),
          ),
          const Gap(5),
          SizedBox(
            height: 251,
            child: ListView.separated(
                padding: const EdgeInsets.all(16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => buidcart(item: items[index]),
                separatorBuilder: (context, index) => const SizedBox(
                      width: 13,
                    ),
                itemCount: items.length),
          ),
          const Gap(5),
          Text(
            'Suggested',
            style: GoogleFonts.b612(fontWeight: FontWeight.bold, fontSize: 19),
          ),
          const Gap(11),
          SizedBox(
            height: 251,
            width: MediaQuery.sizeOf(context).width * 0.97,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.asset(
                  'Beauty/images/img12.jpg',
                  fit: BoxFit.cover,
                )),
          ),
          const Gap(11),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recomended',
                  style: GoogleFonts.b612(
                      fontSize: 19, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Beauty_Recommended(),
                          ));
                    },
                    child: const Text(
                      'Show all',
                      style: TextStyle(),
                    ))
              ],
            ),
          ),
          const Gap(5),
          SizedBox(
            height: 251,
            child: ListView.separated(
                padding: const EdgeInsets.all(16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    buidcart(item: recomended[index]),
                separatorBuilder: (context, index) => const SizedBox(
                      width: 13,
                    ),
                itemCount: recomended.length),
          ),
          const Gap(5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Top Collection',
                  style: GoogleFonts.b612(
                      fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Gap(5),
          Collection(),
        ],
      ),
    );
  }

  Widget buildindicator(Smooth_Page pageProvider, int count) {
    return AnimatedSmoothIndicator(
      effect: const WormEffect(
        dotWidth: 15,
        type: WormType.normal,
        activeDotColor: Colors.blue,
      ),
      activeIndex: pageProvider.InitialPage,
      count: count,
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

  Widget Collection() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: SizedBox(
            height: 251,
            width: MediaQuery.sizeOf(context).width * 0.97,
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(
                          image: 'Beauty/images/img13.jpg',
                          price: 100.0,
                          name: 'Lorum ipsum',
                          description: des,
                        ),
                      ));
                },
                child: InkWell(
                    child: Image.asset(
                  'Beauty/images/img13.jpg',
                  fit: BoxFit.cover,
                ))),
          ),
        ),
        const Gap(11),
        ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: SizedBox(
            height: 251,
            width: MediaQuery.sizeOf(context).width * 0.97,
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(
                          image: 'Beauty/images/img17.jpg',
                          price:  100.0,
                          name: 'Lorum ipsum',
                          description: des,
                        ),
                      ));
                },
                child: Image.asset(
                  'Beauty/images/img17.jpg',
                  fit: BoxFit.cover,
                )),
          ),
        ),
        const Gap(11),
        ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: SizedBox(
            height: 251,
            width: MediaQuery.sizeOf(context).width * 0.97,
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(
                          image: 'Beauty/images/img15.jpg',
                          price:  100.0,
                          name: 'Lorum ipsum',
                          description: des,
                        ),
                      ));
                },
                child: Image.asset(
                  'Beauty/images/img15.jpg',
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ],
    );
  }

  Widget buildimage(String Urlimage, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(19),
      child: Image.asset(
        Urlimage,
        fit: BoxFit.cover,
      ),
    );
  }
}
