import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/small_text.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({ Key? key, required this.text }) : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String previewText;
  late String extraText;
  bool hiddenText = true;
  double textHeight = Dimensions.height(250);

  @override
  void initState() {
    super.initState();
    if(widget.text.length > textHeight){
      previewText = widget.text.substring(0, textHeight.toInt());
      extraText = widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    }
    else{
      previewText = widget.text;
      extraText = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: extraText.isEmpty ?
        SmallText(
          text: previewText,
          size: Dimensions.height(16),
          color: AppColors.paraColor,
          height: 2.0,
        ) :
        Container(
          child: Column(
            children: [
              SmallText(
                text: hiddenText ? previewText + "..." : (previewText + extraText),
                size: Dimensions.height(16),
                color: AppColors.paraColor,
                height: 2.0,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    hiddenText = !hiddenText;
                  });
                },
                child: Row(
                  children: [
                    SmallText(text: hiddenText ? "Show more" : "Show less",
                    color: AppColors.mainColor),
                    Icon(hiddenText ? Icons.arrow_drop_down : Icons.arrow_drop_up, color: AppColors.mainColor),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}