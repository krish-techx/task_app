import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';

class StarBuilder extends StatelessWidget {
  final double? rating;
  final double? starSize;

  const StarBuilder({super.key, this.rating, this.starSize = 15});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index + 1 <= (rating ?? 0)) {
          return Icon(Icons.star, color: AppColors.secondary, size: starSize);
        } else if (index < 2.4 && index + 1 > 2.4) {
          return Icon(
            Icons.star_half,
            color: AppColors.secondary,
            size: starSize,
          );
        } else {
          return Icon(
            Icons.star_border,
            color: AppColors.secondary,
            size: starSize,
          );
        }
      }),
    );
  }
}
