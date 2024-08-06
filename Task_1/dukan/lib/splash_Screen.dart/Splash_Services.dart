import 'dart:async';

import 'package:dukan/screens/HomeScreens/Home_Screen.dart';
import 'package:dukan/screens/Welcome_Screen.dart';
import 'package:dukan/screens/seller_Screens/seller_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashServices {
  void Splash(context) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userRole = prefs.getString('userRole');

    if (user == null || userRole == null) {
      Timer(const Duration(seconds: 1), () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomeScreen(),
            ));
      });
    } else {
      Timer(const Duration(seconds: 1), () {
        if (userRole == 'buyer') {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
        } else if (userRole == 'seller') {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Seller_Screen(),
              ));
        }
      });
    }
  }
}

void Splash(context) {
  final auth = FirebaseAuth.instance;

  final user = auth.currentUser;

  if (user == null) {
    Timer(const Duration(seconds: 1), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomeScreen(),
          ));
    });
  } else {
    Timer(const Duration(seconds: 1), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    });
  }
}
