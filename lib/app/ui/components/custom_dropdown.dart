import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final Function(String?, int) onChanged;
  final bool isEnabled;

  const CustomDropdown({
    super.key,
    required this.items,
    this.selectedItem,
    required this.onChanged,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedItem,
      items: items.asMap().entries.map((entry) {
        int index = entry.key;
        String value = entry.value;
        return DropdownMenuItem<String>(
          value: value,
          child: SizedBox(
            width: 326,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
          onTap: () => onChanged(value, index),
        );
      }).toList(),
      onChanged: isEnabled
          ? (value) {
              int index = items.indexOf(value!);
              onChanged(value, index);
            }
          : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
