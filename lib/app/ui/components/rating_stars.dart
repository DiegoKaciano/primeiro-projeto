import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final int rating;
  final Function(int) onRatingChanged;

  const RatingStars({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: index < rating ? Colors.amber : Colors.grey,
          ),
          onPressed: () {
            final check = index + 1 == rating;
            onRatingChanged(check ? 0 : index + 1);
          },
        );
      }),
    );
  }
}
