

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_clean_bangladesh/user/login.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../utils/shared_preference.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'Welcome\n to Green Clean Bangladesh',
            body:
            'We are a waste cleaner and collection company in Dhaka.',
            image: build_image('assets/images/gcb.png'),
            decoration: get_decoration1(),
          ),
          PageViewModel(
            title: 'Best Waste Management Company',
            body: 'GCB is well known for their best quality assurance.',
            image: build_image('assets/images/energy.png'),
            decoration: get_decoration(),
          ),
          PageViewModel(
            title: 'Committed Service Ever',
            body:
            'With the best result given by GCB, it is now a brand of trust.',
            image: build_image('assets/images/partnership.png'),
            decoration: get_decoration(),
          ),
        ],

        next: Icon(Icons.arrow_forward_rounded, color: Color(0xFF00A669),),

        done: Text(
          'Go',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF00A669),
          ),
        ),

        onDone: () {
          goto_login_page(context);
        },

        showSkipButton: true,
        skip: Text('Skip',
          style: TextStyle(
            color: Color(0xFF00A669)
          ),),

        dotsDecorator: get_decorator(),

        onChange: (index) => print('Page $index Selected!'),
        //globalBackgroundColor: Theme.of(context).primaryColor,

        skipOrBackFlex: 0,
        nextFlex: 0,
      ),
    );
  }

  Widget build_image(String s) {
    return Center(child: Image.asset(s));
  }

  PageDecoration get_decoration() {
    return PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w500,
      ),

      bodyTextStyle: TextStyle(
        fontSize: 20,
      ),

      bodyPadding: EdgeInsets.all(10.0).copyWith(bottom: 0),

      imagePadding: EdgeInsets.only(top: 50, left: 50, right: 50),

      pageColor: Colors.white,
      //contentMargin: EdgeInsets.only(top: 30),

      imageFlex: 2,
    );
  }

  PageDecoration get_decoration1() {
    return PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        wordSpacing: 5,
        letterSpacing: 3,
      ),

      bodyTextStyle: TextStyle(
        fontSize: 20,
      ),

      bodyPadding: EdgeInsets.all(10.0).copyWith(bottom: 0),

      imagePadding: EdgeInsets.only(top: 50, left: 50, right: 50),

      pageColor: Colors.white,
      //contentMargin: EdgeInsets.only(top: 30),

      imageFlex: 1,
    );
  }

  void goto_login_page(BuildContext context) async {
    await Shared_Prefference_Class.init();
    await Shared_Prefference_Class.set_OnBoarding_Status(true);
    //await print(Shared_Prefference_Class.get_OnBoarding_Status().toString());
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (_) => Login_Page()),
    // );
    Get.offAll(Login_Page());
  }

  DotsDecorator get_decorator() {
    return DotsDecorator(
      color: Color(0xFFBDBDBD),
      activeColor: Color(0xFF00A669),
      size: Size(10, 10),
      activeSize: Size(22, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }


}
