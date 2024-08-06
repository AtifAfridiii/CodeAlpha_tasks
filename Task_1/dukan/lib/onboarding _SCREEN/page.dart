import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Page_View extends StatelessWidget {
  final String image, title, description, buttontext;
  final Function() onPressed;

  const Page_View(
      {super.key,
      required this.image,
      required this.title,
      required this.buttontext,
      required this.description,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              title.toString(),
              style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Gap(11),
            Text(
              description.toString(),
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
            const Gap(11),
            SizedBox(
              height: height * 0.69,
              width: width,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(image, fit: BoxFit.fitHeight),
                    ),
                  ),
                  const Gap(21),
                  InkWell(
                    onTap: () => onPressed(),
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.07,
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(51),
                          border: Border.all(color: Colors.white)),
                      child: Center(
                          child: Text(
                        buttontext,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
