import 'package:flutter/material.dart';

class CustomSearchTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String) onSubmitted;

  const CustomSearchTextField({
    super.key,
    this.focusNode,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: 'Procurar um jogo',
        prefixIcon: Icon(Icons.search, color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[800],
        contentPadding: EdgeInsets.all(12.0),
      ),
      style: TextStyle(color: Colors.white),
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitted,
    );
  }
}
