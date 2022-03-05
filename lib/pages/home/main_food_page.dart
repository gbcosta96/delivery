import 'package:delivery/pages/home/food_page_body.dart';
import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:delivery/widgets/small_text.dart';
import 'package:flutter/material.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({ Key? key }) : super(key: key);

  @override
  _MainFoodPageState createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: Dimensions.height(45),
              bottom: Dimensions.height(15)
            ),
            padding: EdgeInsets.only(
              left: Dimensions.width(20),
              right: Dimensions.width(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text: "Brasil", color: AppColors.mainColor),
                    Row(
                      children: [
                        SmallText(text: "Florianópolis", color: Colors.black54),
                        const Icon(Icons.arrow_drop_down_rounded)
                    ],)
                    
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimensions.smallest(45),
                    height: Dimensions.smallest(45),
                    child: Icon(Icons.search, color: Colors.white, size: Dimensions.smallest(24)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.smallest(15)),
                      color: AppColors.mainColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              child: FoodPageBody(),
            ),
          ),
        ],
      ),
    );
  }
}