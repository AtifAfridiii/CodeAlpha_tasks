import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: GoogleFonts.b612(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const Card(
                child: ListTile(
                  title: Text('Good morning! Get 20% Voucher'),
                  subtitle: Text(
                      'Summer sale up to 20% off. Limited voucher. Get now!! 😜'),
                ),
              )
                  .animate()
                  .fade(
                      curve: const FlippedCurve(Curves.bounceIn),
                      begin: 3,
                      duration: const Duration(seconds: 1))
                  .scale(),
              const Card(
                child: ListTile(
                  title: Text('Special offer just for you'),
                  subtitle: Text('New Autumn Collection 30% off'),
                ),
              )
                  .animate()
                  .fade(
                      curve: const FlippedCurve(Curves.bounceIn),
                      begin: 3,
                      duration: const Duration(seconds: 1))
                  .scale(),
              const Card(
                child: ListTile(
                  title: Text('Holiday sale 50%'),
                  subtitle: Text('Tap here to get 50% voucher.'),
                ),
              )
                  .animate()
                  .fade(
                      curve: const FlippedCurve(Curves.bounceIn),
                      begin: 3,
                      duration: const Duration(seconds: 1))
                  .scale()
            ],
          );
        },
      ),
    );
  }
}
