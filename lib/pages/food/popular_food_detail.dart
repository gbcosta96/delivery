
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/data/controllers/cart_controller.dart';
import 'package:delivery/data/controllers/popular_product_controller.dart';
import 'package:delivery/models/products_model.dart';
import 'package:delivery/routes/route_helper.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/app_column.dart';
import 'package:delivery/widgets/app_icon.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:delivery/widgets/expandable_text.dart';
import 'package:delivery/widgets/progress_circular.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  const PopularFoodDetail({ Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: CachedNetworkImage(
              imageUrl: AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
              imageBuilder: (context, imageProvider) =>
              Container(
                width: double.maxFinite,
                height: Dimensions.height(350),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageProvider,
                  )
                ),
              ),
              placeholder: (context, url) => ProgressCircular(height: Dimensions.height(350)),
            ),
          ),
          Positioned(
            top: Dimensions.height(45),
            left: Dimensions.width(20),
            right: Dimensions.width(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap:() => Get.toNamed(RouteHelper.getInitial()),
                  child: const AppIcon(icon: Icons.arrow_back_ios_new),
                ),
                GetBuilder<PopularProductController>(builder: (controller){
                  return Stack(
                    children: [
                      AppIcon(icon: Icons.shopping_cart_outlined),
                      controller.totalItems >= 1 ? 
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: Dimensions.smallest(20),
                          height: Dimensions.smallest(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.smallest(20)/2),
                            color: AppColors.mainColor,
                          ),
                          child: Center(
                            child: BigText(
                              text: controller.totalItems.toString(),
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ) : 
                      Container(),
                    ],
                  ); 
                }),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.height(350 - 30),
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width(20),
                right: Dimensions.width(20),
                top: Dimensions.height(20),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.smallest(20)),
                  topRight: Radius.circular(Dimensions.smallest(20)),
                ),
                color: Colors.white,      
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name!),
                  SizedBox(height: Dimensions.height(20)),
                  const BigText(text: "Introduce"),
                  SizedBox(height: Dimensions.height(20)),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      child: ExpandableText(
                        text: product.description!,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
          height: Dimensions.height(120),
          padding: EdgeInsets.only(
            top: Dimensions.height(30),
            bottom: Dimensions.height(30),
            left: Dimensions.width(20),
            right: Dimensions.width(20),
          ),
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.smallest(40)),
              topRight: Radius.circular(Dimensions.smallest(40)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height(20),
                  bottom: Dimensions.height(20),
                  left: Dimensions.width(20),
                  right: Dimensions.width(20),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.smallest(20)),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => popularProduct.setQuantity(false),
                      child: const Icon(Icons.remove, color: AppColors.signColor),
                    ),
                    SizedBox(width: Dimensions.width(5)),
                    BigText(text: popularProduct.inCartItems.toString()),
                    SizedBox(width: Dimensions.width(5)),
                    GestureDetector(
                      onTap: () => popularProduct.setQuantity(true),
                      child: const Icon(Icons.add, color: AppColors.signColor),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => popularProduct.addItem(product),
                child: Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height(20),
                    bottom: Dimensions.height(20),
                    left: Dimensions.width(15),
                    right: Dimensions.width(15),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.smallest(20)),
                    color: AppColors.mainColor,
                  ),
                  child: BigText(text: "\$${product.price!*popularProduct.inCartItems} | Add to cart", color: Colors.white),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}