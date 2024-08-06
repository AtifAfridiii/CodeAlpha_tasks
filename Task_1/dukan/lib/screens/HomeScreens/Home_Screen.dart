import 'package:dukan/Utilis/toast_message.dart';
import 'package:dukan/provider/Bottom_Bar.dart';
import 'package:dukan/provider/ItemAdded.dart';
import 'package:dukan/provider/theme.dart';
import 'package:dukan/screens/HomeScreens/Cart_Screen.dart';
import 'package:dukan/screens/HomeScreens/Products_Screen.dart';
import 'package:dukan/screens/HomeScreens/Search_Screen.dart';
import 'package:dukan/screens/Notifications/notification.dart';
import 'package:dukan/screens/Signup_Screens/SignUp_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> screens = [
    const Felmale(),
    const SearchScreen(),
    const Cart_Screen(),
  ];

  @override
  Widget build(BuildContext context) {
    final indexProvider = Provider.of<Selected_Index>(context, listen: false);
    final Iconprovider = Provider.of<ThemeChanger>(context);
    bool ISDark = Iconprovider.Thememode == ThemeMode.dark;

    final auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dukan',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationScreen(),
                    ));
              },
              child: Badge(
                  alignment: const Alignment(BorderSide.strokeAlignOutside,
                      BorderSide.strokeAlignInside),
                  largeSize: 51,
                  smallSize: 11,
                  child: SvgPicture.asset(
                    'Assets/images/bell.svg',
                    color: ISDark ? Colors.white : Colors.black,
                  ))),
          const Gap(15),
        ],
        leading: Builder(
          builder: (context) => InkWell(
            child: SvgPicture.asset(
              'Assets/images/menu.svg',
              color: ISDark ? Colors.white : Colors.black,
            ),
            onTap: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.5,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 51,
                      child: Image.asset('Assets/images/prof.png'),
                    ),
                    const Gap(11),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Atif Afridi',
                          style: GoogleFonts.b612(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const Text('(admin)')
                      ],
                    ),
                    const Text(
                      'atifafridi378@gmail.com',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                )),
            ListTile(
              leading: SvgPicture.asset(
                'Assets/images/home.svg',
                color: ISDark ? Colors.white : Colors.black,
              ),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                'Assets/images/search.svg',
                color: ISDark ? Colors.white : Colors.black,
              ),
              title: const Text('Discover'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ));
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                'Assets/images/order.svg',
                height: 25,
                color: ISDark ? Colors.white : Colors.black,
              ),
              title: const Text('My order'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Cart_Screen(),
                    ));
              },
            ),
            Consumer<ItemAdded>(
              builder: (context, value, child) {
                return ListTile(
                  leading: const Icon(Icons.logout_rounded),
                  title: const Text('Log out'),
                  onTap: () {
                    value.clearCart();
                    auth.signOut().then(
                      (value) async {
                        Utilis().ToastMessage('Log out');

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ));
                      },
                    ).onError(
                      (error, stackTrace) {
                        Utilis().ToastMessage(error.toString());
                      },
                    );
                  },
                );
              },
            ),
            Consumer<ThemeChanger>(
              builder: (context, themeChanger, child) {
                bool isDarkMode = themeChanger.Thememode == ThemeMode.dark;
                return ListTile(
                  leading:
                      Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (bool value) {
                      themeChanger
                          .setTheme(value ? ThemeMode.dark : ThemeMode.light);
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
      body: Consumer<Selected_Index>(
        builder: (context, value, child) {
          return screens[indexProvider.SelectedIndex];
        },
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(31),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Consumer<Selected_Index>(
            builder: (context, value, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(31),
                child: GNav(
                  backgroundColor: Colors.blueGrey.shade700,
                  selectedIndex: value.SelectedIndex,
                  onTabChange: (val) {
                    value.onItemTapped(val);
                  },
                  curve: Curves.linear,
                  rippleColor: Colors.deepPurple,
                  tabBackgroundColor: Colors.teal,
                  activeColor: Colors.white,
                  style: GnavStyle.google,
                  gap: 9,
                  iconSize: 31,
                  padding: const EdgeInsets.all(15),
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.search,
                      text: 'Discover',
                    ),
                    GButton(
                      icon: Icons.shopping_bag_outlined,
                      text: 'Cart',
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
