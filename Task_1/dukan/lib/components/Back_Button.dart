import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Back_Button extends StatelessWidget {
  final VoidCallback onpressed;
  const Back_Button({super.key, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onpressed,
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.2,
          width: MediaQuery.sizeOf(context).width * 0.1,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: BorderSide.strokeAlignOutside,
                    spreadRadius: 1,
                    blurStyle: BlurStyle.normal)
              ]),
          child: Center(
              child: SvgPicture.asset(
            'Assets/images/bac.svg',
            height: 29,
          )),
        ),
      ),
    );
  }
}
