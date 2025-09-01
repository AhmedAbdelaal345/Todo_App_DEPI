import 'package:flutter/material.dart';

class StateCardWidget extends StatelessWidget {
  const StateCardWidget({super.key,required this.label,required this.count,required this.color});
final String label;
final int count;
final Color color;
  @override
  Widget build(BuildContext context) {
     
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  
  }
}