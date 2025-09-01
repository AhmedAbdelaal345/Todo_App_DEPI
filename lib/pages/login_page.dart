import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/helper/button_widget.dart';
import 'package:todoapp/helper/google_button.dart';
import 'package:todoapp/helper/text_form_field_widget.dart';
import 'package:todoapp/manager/cubit/todo_cubit.dart';
import 'package:todoapp/pages/register_page.dart';
import 'package:todoapp/pages/wrapper_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  static const String id = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Image.asset(Constants.logo, height: 50),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey, // THIS IS CRUCIAL - Connect the formKey to the Form
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 15),

              TextFormFieldWidget(
                controller: emailController,
                isPassword: false,
                labelText: "Email",
                hintText: "Enter your email",
                formKey: formKey,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 15),
              TextFormFieldWidget(
                controller: passwordController,
                isPassword: true,
                labelText: "Password",
                hintText: "Enter your password",
                formKey: formKey,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 15),

              ButtonWidget(
                onPressed: isLoading
                    ? null
                    : () async {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }

                        setState(() {
                          isLoading = true;
                        });

                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text,
                              );
                          context.read<TodoCubit>().setUserData(
                            email: credential.user!.email!,
                            password: passwordController.text,
                            uid: credential.user!.uid,
                          );
                          if (credential.user != null) {
                            Navigator.pushReplacementNamed(
                              context,
                              WrapperPage.id,
                            );

                            Fluttertoast.showToast(
                              msg: "Login successful!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          String errorMessage;

                          switch (e.code) {
                            case 'user-not-found':
                              errorMessage = 'No user found for that email.';
                              break;
                            case 'wrong-password':
                              errorMessage =
                                  'Wrong password provided for that user.';
                              break;
                            case 'invalid-email':
                              errorMessage = 'Invalid email address.';
                              break;
                            case 'user-disabled':
                              errorMessage = 'This account has been disabled.';
                              break;
                            case 'too-many-requests':
                              errorMessage =
                                  'Too many failed attempts. Try again later.';
                              break;
                            case 'invalid-credential':
                              errorMessage = 'Invalid email or password.';
                              break;
                            default:
                              errorMessage = 'Login failed. Please try again.';
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
                          print("Login error: $e");
                          Fluttertoast.showToast(
                            msg:
                                "An unexpected error occurred. Please try again.",
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
                      },
                text: isLoading ? "Logging in..." : "Login",
                backgroundColor: Constants.primaryColor,
                borderColor: Constants.primaryColor,
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              GoogleSignInButton(
                // Navigate to home page after successful Google sign-in
                onError: (error) {
                  Fluttertoast.showToast(
                    msg: "Google Sign-In Failed: $error",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "if you don't have an account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterPage.id);
                    },
                    child: Text(
                      "Sign Up Here",
                      style: TextStyle(color: Colors.blue),
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
