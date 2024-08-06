// ignore_for_file: file_names

import 'package:dukan/provider/theme.dart';
import 'package:dukan/screens/TabBar_screen/first_tab.dart';
import 'package:dukan/screens/TabBar_screen/fourth_tab.dart';
import 'package:dukan/screens/TabBar_screen/live.dart';
import 'package:dukan/screens/TabBar_screen/second_tab.dart';
import 'package:dukan/screens/TabBar_screen/third_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class Felmale extends StatefulWidget {
  const Felmale({super.key});

  @override
  State<Felmale> createState() => _FelmaleState();
}

class _FelmaleState extends State<Felmale> {
  @override
  Widget build(BuildContext context) {
    final Iconprovider = Provider.of<ThemeChanger>(context);
    bool ISDark = Iconprovider.Thememode == ThemeMode.dark;
    return Scaffold(
      body: DefaultTabController(
        length: 5,
        child: Column(
          children: [
            Material(
              child: Container(
                padding: const EdgeInsets.all(10),
                height: MediaQuery.sizeOf(context).height * 0.099,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent, width: 0)),
                child: TabBar(
                  physics: const ClampingScrollPhysics(),
                  unselectedLabelColor: Colors.pink,
                  indicatorSize: TabBarIndicatorSize.label,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                      color: const Color.fromARGB(255, 64, 186, 68),
                      borderRadius: BorderRadius.circular(101),
                      border: Border.all()),
                  tabs: [
                    Tab(
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.1,
                        width: MediaQuery.sizeOf(context).height * 0.07,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ISDark ? Colors.white : Colors.black54,
                              width: 1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'Assets/images/male.svg',
                            color: ISDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.1,
                        width: MediaQuery.sizeOf(context).height * 0.07,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ISDark ? Colors.white : Colors.black54,
                              width: 1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'Assets/images/female.svg',
                            color: ISDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.1,
                        width: MediaQuery.sizeOf(context).height * 0.07,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ISDark ? Colors.white : Colors.black54,
                              width: 1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'Assets/images/glasses.svg',
                            color: ISDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.1,
                        width: MediaQuery.sizeOf(context).height * 0.07,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ISDark ? Colors.white : Colors.black54,
                              width: 1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'Assets/images/cos.svg',
                            color: ISDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.1,
                        width: MediaQuery.sizeOf(context).height * 0.07,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ISDark ? Colors.white : Colors.black54,
                              width: 1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'Assets/images/ad.svg',
                            color: ISDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(7),
            const Expanded(
              child: TabBarView(
                children: [
                  FirstTabContent(),
                  SecondTabContent(),
                  ThirdTabContent(),
                  FourthTabContent(),
                  FifthScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
