// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  String title;
  final Function() ontap;
  Color color;

  RoundButton(
      {super.key,
      required this.title,
      required this.ontap,
      this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap();
      },
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.07,
        width: MediaQuery.sizeOf(context).width * 0.6,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(51),
            border: Border.all(color: Colors.white)),
        child: Center(
            child: Text(
          title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
