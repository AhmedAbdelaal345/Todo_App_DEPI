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
    // Get screen size for responsive design
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenSize.height * 0.05, // 5% of screen height
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center content vertically
              children: [
                TextWidget(
                  text: "Welcome to UpTodo",
                  size:
                      screenSize.width *
                      0.08, // Responsive font size (8% of screen width)
                  weight: FontWeight.bold,
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                ), // Responsive spacing
                Align(
                  alignment: Alignment.center,
                  child: TextWidget(
                    text:
                        "Please login to your account or create new account to continue",
                    size:
                        screenSize.width *
                        0.04, // Responsive font size (4% of screen width)
                    weight: FontWeight.w200,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.03),
                // Make Lottie animation size responsive
                Lottie.asset(
                  Constants.welcomeLottie,
                  height: screenSize.height * 0.38, // 25% of screen height
                  width: screenSize.width * 0.5, // 50% of screen width
                  fit: BoxFit.fill, // Use contain to prevent distortion
                ),
                const Spacer(), // Flexible spacer to push buttons to bottom
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
