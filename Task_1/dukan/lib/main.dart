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
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';


Future<void> initHive() async {
  await Hive.initFlutter();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  
  if (!Hive.isAdapterRegistered(CartModelAdapter().typeId)) {
    Hive.registerAdapter(CartModelAdapter());
  }
  if (!Hive.isAdapterRegistered(AdModelAdapter().typeId)) {
    Hive.registerAdapter(AdModelAdapter());
  }
}

Future<Box<T>> openBox<T>(String boxName) async {
  if (Hive.isBoxOpen(boxName)) {
    return Hive.box<T>(boxName);
  } else {
    return await Hive.openBox<T>(boxName);
  }
}

Future<void> migrateHiveData() async {
  var box = await openBox<dynamic>('Cart');
  
  for (var key in box.keys) {
    var item = box.get(key);
    if (item is Map<String, dynamic>) {
      try {
        var cartModel = CartModel.fromJson(item);
        await box.put(key, cartModel);
      } catch (e) {
        print('Error migrating item $key: $e');
        await box.delete(key);
      }
    }
  }
  
  await box.close();
  await openBox<CartModel>('Cart');
}

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    StripServices.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
    await initHive();
    await migrateHiveData();
    await openBox<AdModel>('Ad');
    
    runApp(const MyApp());
  } catch (e) {
    print('Error during initialization: $e');
   
  }
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
          return Consumer<ThemeChanger>(
            builder: (context, value, child) {
              return MaterialApp(
                title: 'Flutter Demo',
                themeMode: themechnager.Thememode,
                theme: ThemeData(
                  brightness: Brightness.light,
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                darkTheme: ThemeData(
                  brightness: Brightness.dark,
                ),
                home: const Splash_Screen(),
              );
            },
          );
        },
      ),
    );
  }
}
