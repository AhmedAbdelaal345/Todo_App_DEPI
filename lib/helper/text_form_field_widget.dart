import 'package:flutter/material.dart';
import 'package:todoapp/constants.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.isPassword,
    required this.labelText,
    required this.hintText,
    required this.formKey,
  });
  
  final TextEditingController? controller;
  final bool isPassword;
  final String labelText;
  final String hintText;
  final GlobalKey<FormState> formKey;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool isObscure = true;
  
  // Email validation regex
  final String emailRegex = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
  
  // Password validation regex
  final String passwordRegex = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        // Check if value is empty
        if (value == null || value.isEmpty) {
          return 'Please enter ${widget.labelText.toLowerCase()}';
        }
        
        // Validate based on field type
        if (!widget.isPassword) {
          // Email validation
          if (!RegExp(emailRegex).hasMatch(value)) {
            return 'Please enter a valid email address';
          }
        } else {
          // Password validation
          if (value.length < 6) {
            return 'Password must be at least 6 characters long';
          }
          // Uncomment below for stricter password validation
          /*
          if (!RegExp(passwordRegex).hasMatch(value)) {
            return 'Password must include uppercase, lowercase, number, and special character';
          }
          */
        }
        return null;
      },
      controller: widget.controller,
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      obscureText: isObscure && widget.isPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Constants.textFiledBorderColor,
            width: 0.8,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Constants.textFiledBorderColor,
            width: 0.8,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 0.8,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 0.8,
          ),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                  color: Constants.textFiledTextColor,
                ),
              )
            : null,
        fillColor: Constants.textFiledbackGround,
        filled: true,
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: Colors.white),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Constants.textFiledTextColor),
      ),
    );
  }
}