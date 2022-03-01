import 'dart:math';

import 'package:get/get.dart';

class Dimensions{
  static final double _screenHeight = Get.context!.height;
  static final double _screenWidth = Get.context!.width;

  static double height(double height){
    return _screenHeight/(844/height);
  } 

  static double width(double width){
    return _screenWidth/(390/width);
  }

  static double smallest(double size){
    return min(height(size), width(size));
  }

  static double greatest(double size){
    return max(height(size), width(size));
  }

  
}