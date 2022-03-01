import 'package:delivery/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final TextOverflow overflow;

  const BigText({ Key? key,
    this.color = const Color(0xFF332D2B),
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.size = 20,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: Dimensions.height(size),
      ),
    );
  }
}