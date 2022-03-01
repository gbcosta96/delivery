import 'package:delivery/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;

  const SmallText({ Key? key,
    this.color = const Color(0xFFCCC7C5),
    required this.text,
    this.size = 12,
    this.height = 1.2,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: 'Roboto',
        fontSize: size,
        height: Dimensions.height(height),
      ),
    );
  }
}