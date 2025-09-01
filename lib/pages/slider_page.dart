import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todoapp/pages/get_started.dart';

class SliderPage extends StatelessWidget {
  const SliderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(scaffoldBackgroundColor: Colors.black),
      home: OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        finishButtonText: 'Get Started',
        onFinish: () {
          Navigator.pushReplacementNamed(context, GetStarted.id);
        },
        finishButtonStyle: FinishButtonStyle(backgroundColor: Colors.black),
        skipTextButton: Text('Skip', style: TextStyle(color: Colors.white)),
        trailing: Text('Login', style: TextStyle(color: Colors.white)),

        background: [
          // Wrap SVGs in containers with specific constraints
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: SvgPicture.asset(
              'assets/image/get_started.svg',
              fit: BoxFit.contain,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: SvgPicture.asset(
              'assets/image/page_one.svg',
              fit: BoxFit.contain,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: SvgPicture.asset(
              'assets/image/page_two.svg',
              fit: BoxFit.contain,
            ),
          ),
        ],
        totalPage: 3,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(height: 250),
                Text(
                  'Manage your tasks',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 42),
                Text(
                  'You can easily manage all of your daily tasks in DoMe for free',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(height: 250),
                Text(
                  'Create daily routine',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 42),
                Text(
                  "In Uptodo you can create your personalized routine to stay productive",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(height: 250),
                Text(
                  'Organize your tasks',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 42),
                Text(
                  "You can organize your daily tasks by adding your tasks into separate categories",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
