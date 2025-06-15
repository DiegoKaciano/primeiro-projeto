import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String label;
  const CustomText({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          label,
          style: TextStyle(color: Colors.white70),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
