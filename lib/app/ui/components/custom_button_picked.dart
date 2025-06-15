import 'package:flutter/material.dart';

class CustomButtonPicked extends StatelessWidget {
  final Function() onTap;
  final String selectedGame;

  const CustomButtonPicked({
    super.key,
    required this.selectedGame,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                selectedGame,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.search,
              color: Colors.white70,
            ),
          ],
        ),
      ),
    );
  }
}
