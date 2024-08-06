import 'dart:async';

import 'package:dukan/splash_Screen.dart/Splash_Services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 4),
      () {
        SplashServices().Splash(context);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height * 1,
        width: MediaQuery.sizeOf(context).width * 1,
        child: Lottie.asset('Assets/images/spa.json',
            fit: BoxFit.fill, animate: true, repeat: true, reverse: true),
      ),
    );
  }
}
