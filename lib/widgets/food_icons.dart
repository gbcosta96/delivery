import 'package:delivery/utils/colors.dart';
import 'package:flutter/material.dart';

import 'icon_and_text.dart';

class FoodIcons extends StatelessWidget {
  final String foodType;
  final String distance;
  final String time;

  const FoodIcons({ Key? key,
    required this.foodType,
    required this.distance,
    required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconAndText(
          icon: Icons.circle_sharp,
          text: foodType,
          iconColor: AppColors.iconColor1
        ),
        IconAndText(
          icon: Icons.location_on,
          text: distance,
          iconColor: AppColors.mainColor
        ),
        IconAndText(
          icon: Icons.access_time_rounded,
          text: time,
          iconColor: AppColors.iconColor2
        ),
      ],
      
    );
  }
}