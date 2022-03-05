import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/data/controllers/cart_controller.dart';
import 'package:delivery/pages/home/main_food_page.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/app_icon.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:delivery/widgets/progress_circular.dart';
import 'package:delivery/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height(60),
            left: Dimensions.width(20),
            right: Dimensions.width(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios_new,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.smallest(24),
                ),
                SizedBox(width: Dimensions.width(100)),
                GestureDetector(
                  onTap: () => Get.to(() => MainFoodPage()),
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.smallest(24),
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.smallest(24),
                ),
              ],
            ),
          ),
          Positioned(
            top: Dimensions.height(100),
            left: Dimensions.width(20),
            right: Dimensions.width(20),
            bottom: 0,
            child: Container(
              //color: Colors.red,
              margin: EdgeInsets.only(
                top: Dimensions.height(15),
              ),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(
                  builder: (cartController){
                    return ListView.builder(
                      itemCount: cartController.getItems.length,
                      itemBuilder: (_, index){
                        return Container(
                          height: Dimensions.height(100),
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: AppConstants.BASE_URL + AppConstants.UPLOAD_URL + cartController.getItems[index].img!,
                                imageBuilder: (context, imageProvider) =>
                                Container(
                                  width: Dimensions.width(100),
                                  height: Dimensions.height(100),
                                  margin: EdgeInsets.only(
                                    bottom: Dimensions.height(20),
                                  ),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: imageProvider,
                                    ),
                                    borderRadius: BorderRadius.circular(Dimensions.smallest(20)),
                                    color: Colors.white,
                                  ),
                                ),
                                placeholder: (context, url) =>
                                ProgressCircular(
                                  height: Dimensions.height(100),
                                  width: Dimensions.width(100),
                                ),
                              ),
                              SizedBox(width: Dimensions.width(10)),
                              Expanded(
                                child: Container(
                                  height: Dimensions.height(100),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(
                                        text: cartController.getItems[index].name!,
                                        color: Colors.black54,  
                                      ),
                                      SmallText(text: "Spicy"),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                            text: "\$ ${cartController.getItems[index].price!}",
                                            color: Colors.redAccent,  
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              top: Dimensions.height(10),
                                              bottom: Dimensions.height(10),
                                              left: Dimensions.width(10),
                                              right: Dimensions.width(10),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.smallest(20)),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {},//popularProduct.setQuantity(false),
                                                  child: const Icon(Icons.remove, color: AppColors.signColor),
                                                ),
                                                SizedBox(width: Dimensions.width(5)),
                                                BigText(text: "0"),//popularProduct.inCartItems.toString()),
                                                SizedBox(width: Dimensions.width(5)),
                                                GestureDetector(
                                                  onTap: () => {},//popularProduct.setQuantity(true),
                                                  child: const Icon(Icons.add, color: AppColors.signColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}