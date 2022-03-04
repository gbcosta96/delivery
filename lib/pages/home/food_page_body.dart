import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/data/controllers/popular_product_controller.dart';
import 'package:delivery/models/products_model.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/app_column.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:delivery/widgets/food_icons.dart';
import 'package:delivery/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({ Key? key }) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _heigth = Dimensions.height(220);
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // horizontal slide
        GetBuilder<PopularProductController>(
          builder: (popularProducts){
            return SizedBox(
              height: Dimensions.height(320),
              child: popularProducts.isLoaded ? PageView.builder(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                controller: pageController,
                itemCount: popularProducts.popularProductList.length,
                itemBuilder: (context, position) {
                return _buildPageItem(position, popularProducts.popularProductList[position]);
              }) :
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ),
              )
            );
          }
        ),
        // dots
        GetBuilder<PopularProductController>(
          builder: (popularProducts){
            return DotsIndicator(
              dotsCount: popularProducts.popularProductList.isEmpty ? 
              1 : popularProducts.popularProductList.length,
              position: _currPageValue,
              decorator: DotsDecorator(
                size: Size.square(Dimensions.height(9.0)),
                activeSize: Size(Dimensions.width(18.0), Dimensions.height(9.0)),
                activeColor: AppColors.mainColor,
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            );
          }
        ),
        SizedBox(height: Dimensions.height(30)),
        // popular label
        Container(
          margin: EdgeInsets.only(left: Dimensions.width(30)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const BigText(text: "Popular"),
              SizedBox(width: Dimensions.width(10)),
              Container(
                child: const BigText(text: ".", color: Colors.black26),
                margin: EdgeInsets.only(bottom: Dimensions.height(3)),
              ),
              SizedBox(width: Dimensions.width(10)),
              Container(
                child: const SmallText(text: "Food pairing"),
                margin: EdgeInsets.only(bottom: Dimensions.height(2)),
              ),
            ],
          ),
        ),
        // popular list
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(
                left: Dimensions.width(20),
                right: Dimensions.width(20),
                bottom: Dimensions.height(10),
              ),
              child: Row(
                children: [
                  Container(
                    width: Dimensions.smallest(120),
                    height: Dimensions.smallest(120),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.smallest(20)),
                      color: Colors.white38,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/image/food0.png"),
                        )
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: Dimensions.height(100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.smallest(20)),
                          bottomRight: Radius.circular(Dimensions.smallest(20)),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: Dimensions.width(10),
                          right: Dimensions.width(10)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BigText(text: "Nutritious fruit meal in China"),
                            SizedBox(height: Dimensions.height(10)),
                            SmallText(text: "With chinese characteristics"),
                            SizedBox(height: Dimensions.height(10)),
                            FoodIcons(foodType: "Normal", distance: "1.7km", time: "30m"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
        }),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct){
    Matrix4 matrix = Matrix4.identity();
    if(index <= _currPageValue.floor()){
       var currScale = 1-(_currPageValue - index)*(1 - _scaleFactor);
       var currTrans = _heigth*(1-currScale)/2;
       matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
    else if(index >= _currPageValue.floor() + 1){
      var currScale = _scaleFactor + (_currPageValue - index + 1)*(1 - _scaleFactor);
      var currTrans = _heigth*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: AppConstants.BASE_URL + "/uploads/" + popularProduct.img!,
            imageBuilder: (context, imageProvider) =>
            Container(
              height: _heigth,
              margin: EdgeInsets.only(
                left: Dimensions.width(10),
                right: Dimensions.width(10),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.height(30)),
                color: const Color(0xFF69c5df),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: imageProvider,
                ),
              ),
            ),
            placeholder: (context, url) => 
            SizedBox(
              height: _heigth,
              child: Center(
                child: SizedBox(
                  height: Dimensions.smallest(30),
                  width: Dimensions.smallest(30),
                  child: const CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                ),
              ),
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.height(120),
              margin: EdgeInsets.only(
                left: Dimensions.width(30),
                right: Dimensions.width(30),
                bottom: Dimensions.height(30),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.height(30)),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Color(0xFFE8E8E8), blurRadius: 5.0, offset: Offset(0, 5)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                ]
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height(10),
                  left: Dimensions.width(15),
                  right: Dimensions.width(15),
                ),
                child: AppColumn(text: popularProduct.name!),
              ),
            ),
          ),       
        ],
      ),
    );
  }
}