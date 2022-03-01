import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:delivery/widgets/small_text.dart';
import 'package:flutter/material.dart';

import 'food_icons.dart';

class AppColumn extends StatelessWidget {
  final String text;
  
  const AppColumn({ Key? key,
   required this.text,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: 26),
        SizedBox(height: Dimensions.height(10)),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) { 
                return Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: Dimensions.height(15));
                }
              ),
            ),
            SizedBox(width: Dimensions.width(10)),
            SmallText(text: "4.5"),
            SizedBox(width: Dimensions.width(10)),
            SmallText(text: "1287"),
            SizedBox(width: Dimensions.width(10)),
            SmallText(text: "comments"),
          ],
        ),
        SizedBox(height: Dimensions.height(20)),
        FoodIcons(foodType: "Normal", distance: "1.7km", time: "32min"),
      ],
    );
  }
}