import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final double position;
  final String title;
  final IconData iconData;
  final Function() onTap;

  const CustomFloatingButton({
    super.key,
    required this.position,
    required this.title,
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: position,
      right: 20,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            border: Border.all(
              color: Colors.grey
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
              )
            ]

          ),
          child: Row(
            children: [
              Icon(iconData),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
