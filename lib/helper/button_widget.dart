import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.borderColor,
    required this.onPressed
  });
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final VoidCallback? onPressed ;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStatePropertyAll(Size(double.infinity, 45)),
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(4),
            side: BorderSide(color: borderColor, width: 2),
          ),
        ),
      ),
      onPressed:onPressed??(){} ,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
