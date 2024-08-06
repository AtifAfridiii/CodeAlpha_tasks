import 'package:dukan/onboarding%20_SCREEN/page.dart';
import 'package:dukan/screens/Signup_Screens/SignUp_Screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoarding extends StatefulWidget {
  const onBoarding({super.key});

  @override
  State<onBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
  static final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<Widget> onboarding = [
      Page_View(
        image: 'Assets/images/th.jpg',
        title: 'Discover something new',
        description: 'Special new arrivals just for you',
        buttontext: 'Shopping now',
        onPressed: () {
          _pageController.animateToPage(1,
              duration: const Duration(seconds: 1), curve: Curves.linear);
        },
      ),
      Page_View(
          image: 'Assets/images/thh.jpg',
          title: 'Update trendy outfit',
          description: 'Favourite brands and hot trends ',
          buttontext: 'Shopping now',
          onPressed: () {
            _pageController.animateToPage(2,
                duration: const Duration(seconds: 1), curve: Curves.linear);
          }),
      Page_View(
          image: 'Assets/images/thhh.jpg',
          title: 'Explore your true style',
          description: 'Relax and let us bring the style ',
          buttontext: 'Shopping now',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignupScreen(),
                ));
          }),
    ];
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(61),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child:
                  PageView(controller: _pageController, children: onboarding),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              effect: const WormEffect(
                dotColor: Colors.white,
                activeDotColor: Colors.black,
              ),
              count: onboarding.length,
              onDotClicked: (index) {
                _pageController.animateToPage(index,
                    duration: const Duration(seconds: 1), curve: Curves.linear);
              },
            ),
          ],
        ),
      ),
    );
  }
}
