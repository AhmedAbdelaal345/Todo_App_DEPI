import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/helper/button_widget.dart';
import 'package:todoapp/helper/text_widget.dart';
import 'package:todoapp/pages/login_page.dart';
import 'package:todoapp/pages/register_page.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});
  static const String id = "get_started";

  @override
  Widget build(BuildContext context) {
    
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenSize.height * 0.05, 
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment:
                  MainAxisAlignment.center, 
              children: [
                TextWidget(
                  text: "Welcome to UpTodo",
                  size:
                      screenSize.width *
                      0.08, 
                  weight: FontWeight.bold,
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextWidget(
                    text:
                        "Please login to your account or create new account to continue",
                    size:
                        screenSize.width *
                        0.04, 
                    weight: FontWeight.w200,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.03),
                Lottie.asset(
                  Constants.welcomeLottie,
                  height: screenSize.height * 0.38,
                  width: screenSize.width * 0.5,
                  fit: BoxFit.fill, 
                ),
                const Spacer(), 
                ButtonWidget(
                  text: "LOGIN",
                  backgroundColor: Constants.primaryColor,
                  borderColor: Constants.primaryColor,
                  onPressed: () {
                    Navigator.pushNamed(context, LoginPage.id);
                  },
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
                ), // Responsive spacing
                ButtonWidget(
                  text: "CREATE ACCOUNT",
                  backgroundColor: Colors.black,
                  borderColor: Constants.primaryColor,
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterPage.id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
