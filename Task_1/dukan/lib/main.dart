import 'package:dukan/provider/Bottom_Bar.dart';
import 'package:dukan/provider/ItemAdded.dart';
import 'package:dukan/provider/Page_Indicator.dart';
import 'package:dukan/provider/auth.dart';
import 'package:dukan/provider/cancelled.dart';
import 'package:dukan/provider/delivered.dart';
import 'package:dukan/provider/drop.dart';
import 'package:dukan/provider/iconColor.dart';
import 'package:dukan/provider/loading.dart';
import 'package:dukan/provider/loading2%20.dart';
import 'package:dukan/provider/loading3.dart';
import 'package:dukan/provider/product_color.dart';
import 'package:dukan/provider/seller.dart';
import 'package:dukan/provider/theme.dart';
import 'package:dukan/provider/uplaodI_mage.dart';
import 'package:dukan/screens/CartScreen/cart_model.dart';
import 'package:dukan/splash_Screen.dart/Splash_Screen.dart';
import 'package:dukan/strip/servicess/strip_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  StripServices.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(CartModelAdapter());
  await Hive.openBox<CartModel>('Cart');
  Hive.registerAdapter(AdModelAdapter());
  await Hive.openBox<AdModel>('Ad');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Selected_Index()),
        ChangeNotifierProvider(create: (_) => Smooth_Page()),
        ChangeNotifierProvider(create: (_) => Iconcolor()),
        ChangeNotifierProvider(create: (_) => ProductColor()),
        ChangeNotifierProvider(create: (_) => ItemAdded()),
        ChangeNotifierProvider(create: (_) => dropValue()),
        ChangeNotifierProvider(create: (_) => UploadImage()),
        ChangeNotifierProvider(create: (_) => Loading()),
        ChangeNotifierProvider(create: (_) => Loading2()),
        ChangeNotifierProvider(create: (_) => Loading3()),
        ChangeNotifierProvider(create: (_) => AdProvider()),
        ChangeNotifierProvider(create: (_) => PendingOrdersProvider()),
        ChangeNotifierProvider(create: (_) => DeliveredOrdersProvider()),
        ChangeNotifierProvider(create: (_) => CanceledOrdersProvider()),
        ChangeNotifierProvider(create: (_) => ThemeChanger()),
      ],
      child: Builder(
        builder: (BuildContext context) {
          final themechnager = Provider.of<ThemeChanger>(context);
          return MaterialApp(
            title: 'Flutter Demo',
            themeMode: themechnager.Thememode,
            theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),
            home: const Splash_Screen(),
          );
        },
      ),
    );
  }
}
