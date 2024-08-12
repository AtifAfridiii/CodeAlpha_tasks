import 'package:dukan/screens/CartScreen/cart_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:firebase_database/firebase_database.dart';

class AdProvider extends ChangeNotifier {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('Ads');
  Box<AdModel>? _adsBox;
  String? _currentUserId;

  List<AdModel> get ads => _adsBox?.values.toList() ?? [];

  Future<void> initialize(String userId) async {
    if (_currentUserId != userId) {
     
      await _adsBox?.close();

      
      _adsBox = await Hive.openBox<AdModel>('Ads_$userId');
      _currentUserId = userId;

      await fetchAndStoreAds();
    }
  }

  Future<void> fetchAndStoreAds() async {
    if (_adsBox == null) return;

    _dbRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> values =
            event.snapshot.value as Map<dynamic, dynamic>;
        _adsBox!.clear();
        values.forEach((key, value) {
          _adsBox!.put(
              key,
              AdModel(
                Title: value['Title'] ?? '',
                Description: value['Description'] ?? '',
                price: value['price'],
                image: value['image'],
              ));
        });
        notifyListeners();
      }
    });
  }

  void deleteAd(String key) {
    _adsBox?.delete(key);
    notifyListeners();
  }

  void updateAd(String key, AdModel ad) {
    _adsBox?.put(key, ad);
    notifyListeners();
  }

  Future<void> clearAllAds() async {
    await _adsBox?.clear();
    await _adsBox?.close();
    _adsBox = null;
    _currentUserId = null;
    notifyListeners();
  }

  Box<AdModel>? getData2() => _adsBox;
}
