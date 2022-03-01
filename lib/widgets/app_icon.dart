import 'package:delivery/utils/dimensions.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;

  const AppIcon({ Key? key,
    required this.icon,
    this.backgroundColor = const Color(0xFFFCF4E4) ,
    this.iconColor = const Color(0xFF756D54),
    this.size = 40,
    this.iconSize = 16,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.smallest(size),
      height: Dimensions.smallest(size),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.smallest(size)/2),
        color: backgroundColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: Dimensions.smallest(iconSize),
      ),
    );
  }
}