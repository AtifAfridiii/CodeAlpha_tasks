import 'package:dukan/Utilis/toast_message.dart';
import 'package:dukan/screens/Signup_Screens/SignUp_Screen.dart';
import 'package:dukan/screens/seller_Screens/firstscreen.dart';
import 'package:dukan/screens/seller_Screens/orders/third_screen.dart';
import 'package:dukan/screens/seller_Screens/secondScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/theme.dart';

class Seller_Screen extends StatefulWidget {
  const Seller_Screen({super.key});

  @override
  State<Seller_Screen> createState() => _Seller_ScreenState();
}

final auth = FirebaseAuth.instance;

class _Seller_ScreenState extends State<Seller_Screen> {
  @override
  Widget build(BuildContext context) {
    final Iconprovider = Provider.of<ThemeChanger>(context);
    bool ISDark = Iconprovider.Thememode == ThemeMode.dark;

    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
          automaticallyImplyLeading: false,
          centerTitle: true,
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
                        const Gap(11),
                        ListTile(
                          leading: SvgPicture.asset(
                            'Assets/images/home.svg',
                            width: 31,
                            color: ISDark ? Colors.white : Colors.black,
                          ),
                          title: const Text('Home'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                            leading: SvgPicture.asset(
                              'Assets/images/upload.svg',
                              width: 31,
                            ),
                            title: const Text("Upload "),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const UploadItem(),
                                  ));
                            }),
                        ListTile(
                            leading: SvgPicture.asset(
                              'Assets/images/vp.svg',
                              width: 31,
                            ),
                            title: const Text("View all"),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LiveProduct(),
                                  ));
                            }),
                        ListTile(
                            leading: SvgPicture.asset(
                              'Assets/images/shi.svg',
                              width: 31,
                            ),
                            title: const Text("Orders "),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ThirdScreen(),
                                  ));
                            }),
                        ListTile(
                            leading: const Icon(Icons.logout),
                            title: const Text("Log out "),
                            onTap: () {
                              auth.signOut().then(
                                (value) {
                                  Utilis().ToastMessage('Log out');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupScreen(),
                                      ));
                                },
                              ).onError(
                                (error, stackTrace) {
                                  print(error.toString());
                                },
                              );
                            }),
                        Consumer<ThemeChanger>(
                          builder: (context, themeChanger, child) {
                            bool isDarkMode =
                                themeChanger.Thememode == ThemeMode.dark;
                            return ListTile(
                              leading: Icon(isDarkMode
                                  ? Icons.dark_mode
                                  : Icons.light_mode),
                              trailing: Switch(
                                value: isDarkMode,
                                onChanged: (bool value) {
                                  themeChanger.setTheme(
                                      value ? ThemeMode.dark : ThemeMode.light);
                                },
                              ),
                            );
                          },
                        )
                      ]))
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Builder(builder: (context) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UploadItem(),
                            ));
                      },
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.2,
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(11),
                            border: Border.all(
                              color: ISDark ? Colors.white : Colors.black,
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: BorderSide.strokeAlignOutside,
                                blurStyle: BlurStyle.outer,
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                'Assets/images/upload.svg',
                                height: 91,
                              ),
                            ),
                            const Gap(11),
                            Text(
                              'Add products',
                              style: GoogleFonts.b612(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LiveProduct()));
                    },
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.2,
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(11),
                          border: Border.all(
                            color: ISDark ? Colors.white : Colors.black,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: BorderSide.strokeAlignOutside,
                              blurStyle: BlurStyle.outer,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              'Assets/images/vp.svg',
                              height: 91,
                            ),
                          ),
                          const Gap(11),
                          Text(
                            'View all products',
                            style: GoogleFonts.b612(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(31),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ThirdScreen(),
                      ));
                },
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.3,
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(
                        color: ISDark ? Colors.white : Colors.black,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: BorderSide.strokeAlignOutside,
                          blurStyle: BlurStyle.outer,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          'Assets/images/shi.svg',
                          height: 201,
                        ),
                      ),
                      const Gap(11),
                      Text(
                        'Orders',
                        style: GoogleFonts.b612(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
