import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:flutter/material.dart';

class ProgressCircular extends StatelessWidget {
  final double height;
  final double? width;

  const ProgressCircular({ Key? key,
    required this.height,
    this.width }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.maxFinite,
      height: height,
      child: Center(
        child: SizedBox(
          height: Dimensions.smallest(30),
          width: Dimensions.smallest(30),
          child: const CircularProgressIndicator(
            color: AppColors.mainColor,
          ),
        ),
      ),
    );
  }
}