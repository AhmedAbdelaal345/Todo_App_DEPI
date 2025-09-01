import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/helper/button_widget.dart';
import 'package:todoapp/helper/google_button.dart';
import 'package:todoapp/helper/text_form_field_widget.dart';
import 'package:todoapp/pages/login_page.dart';
import 'package:todoapp/pages/wrapper_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static const String id = "RegisterPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> handleRegister() async {
    // Validate form before proceeding
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Check if passwords match
    if (passwordController.text != confirmPasswordController.text) {
      Fluttertoast.showToast(
        msg: "Passwords do not match",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

      if (credential.user != null) {
        // Optionally send email verification
        await credential.user!.sendEmailVerification();

        // Navigate to login page or home page
        Navigator.pushNamed(context, WrapperPage.id); 

        Fluttertoast.showToast(
          msg:
              "Registration successful! Please check your email for verification.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'An account already exists for that email.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/password accounts are not enabled.';
          break;
        default:
          errorMessage = 'Registration failed. Please try again.';
      }

      print('Firebase Auth Error: ${e.code}');
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      print("Registration error: $e");
      Fluttertoast.showToast(
        msg: "An unexpected error occurred. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Image.asset(Constants.logo,height: 60,),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey, // CRUCIAL: Connect the formKey to the Form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
      
              const Text(
                'Create Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
      
              const SizedBox(height: 8),
      
              const Text(
                'Sign up to get started',
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.center,
              ),
      
              const SizedBox(height: 50),
      
              TextFormFieldWidget(
                controller: emailController,
                isPassword: false,
                labelText: "Email",
                hintText: "Enter your email",
                formKey: formKey,
              ),
      
              const SizedBox(height: 20),
      
              TextFormFieldWidget(
                controller: passwordController,
                isPassword: true,
                labelText: "Password",
                hintText: "Enter your password",
                formKey: formKey,
              ),
      
              const SizedBox(height: 20),
      
              // Confirm Password Field
              TextFormFieldWidget(
                controller: confirmPasswordController,
                isPassword: true,
                labelText: "Confirm Password",
                hintText: "Confirm your password",
                formKey: formKey,
              ),
      
              const SizedBox(height: 30),
      
              Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Colors.grey,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'By registering, you agree to our Terms of Service and Privacy Policy',
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
                  ),
                ],
              ),
      
              const SizedBox(height: 30),
      
              ButtonWidget(
                onPressed: isLoading ? null : handleRegister,
                text: isLoading ? "Creating Account..." : "Register",
                backgroundColor: Constants.primaryColor,
                borderColor: Constants.primaryColor,
              ),
              const SizedBox(height: 20),
              GoogleSignInButton(
                
                onError: (error) {
                  Fluttertoast.showToast(
                    msg: error,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
                
              ),
      
              const SizedBox(height: 20),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, LoginPage.id);
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
