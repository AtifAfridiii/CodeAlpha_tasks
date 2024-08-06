import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //set state is used here
  final searchController = TextEditingController();
  List pics = [
    ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: Image.asset(
          'Cloths/images/img1.jpg',
          fit: BoxFit.cover,
        )),
    ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: Image.asset(
          'Beauty/images/img1.jpg',
          fit: BoxFit.cover,
        )),
    ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: Image.asset(
          'access/images/img3.jpg',
          fit: BoxFit.cover,
        )),
    ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: Image.asset(
          'Products/images/img13.jpg',
          fit: BoxFit.cover,
        )),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Column(
            children: [
              const Gap(5),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(51),
                    border: Border.all(style: BorderStyle.solid),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: BorderSide.strokeAlignOutside,
                          offset: Offset(1, 1),
                          blurStyle: BlurStyle.normal,
                          spreadRadius: 1)
                    ]),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(51),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(51),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(51),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const Gap(11),
              Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  scrollDirection: Axis.vertical,
                  itemCount: pics.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      height: 151,
                      width: 251,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: pics[index],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
