import 'package:dukan/provider/theme.dart';
import 'package:dukan/screens/seller_Screens/orders/canceled.dart';
import 'package:dukan/screens/seller_Screens/orders/delivered.dart';
import 'package:dukan/screens/seller_Screens/orders/pending.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    final Iconprovider = Provider.of<ThemeChanger>(context);
    bool ISDark = Iconprovider.Thememode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: GoogleFonts.b612(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Material(
                child: Container(
                    padding: const EdgeInsets.all(10),
                    height: MediaQuery.sizeOf(context).height * 0.06,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.transparent, width: 0)),
                    child: TabBar(
                      physics: const ClampingScrollPhysics(),
                      unselectedLabelColor:
                          ISDark ? Colors.white : Colors.black,
                      indicatorSize: TabBarIndicatorSize.label,
                      dividerColor: Colors.transparent,
                      labelColor: Colors.white,
                      indicator: BoxDecoration(
                          color: Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(101),
                          border: Border.all()),
                      tabs: [
                        Tab(
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(21),
                              border: Border.all(
                                  color: ISDark ? Colors.white : Colors.black,
                                  width: 1),
                            ),
                            child: const Center(child: Text('Pending')),
                          ),
                        ),
                        Tab(
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(21),
                              border: Border.all(
                                  color: ISDark ? Colors.white : Colors.black,
                                  width: 1),
                            ),
                            child: const Center(child: Text('Delivered')),
                          ),
                        ),
                        Tab(
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(21),
                              border: Border.all(
                                  color: ISDark ? Colors.white : Colors.black,
                                  width: 1),
                            ),
                            child: const Center(child: Text('Cancelled')),
                          ),
                        ),
                      ],
                    ))),
            const Expanded(
                child: TabBarView(
              children: [
                Pending_Order(),
                Delivered_order(),
                Canceled_Order(),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
