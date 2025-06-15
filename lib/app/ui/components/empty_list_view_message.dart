import 'package:flutter/material.dart';

class EmptyListViewMessage extends StatelessWidget {
  final String title;
  const EmptyListViewMessage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.screen_search_desktop_outlined,
              size: 90,
              color: Colors.grey[600],
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
