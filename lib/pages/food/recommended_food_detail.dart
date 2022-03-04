import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/data/controllers/recommended_product_controller.dart';
import 'package:delivery/models/products_model.dart';
import 'package:delivery/routes/route_helper.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/app_icon.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:delivery/widgets/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  const RecommendedFoodDetail({ Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel product = Get.find<RecommendedProductController>().recommendedProductList[pageId];

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: Dimensions.height(80),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const AppIcon(icon: Icons.clear),
                ),
                const AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.height(20)),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  top: Dimensions.height(5),
                  bottom: Dimensions.height(10),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.smallest(20)),
                    topRight: Radius.circular(Dimensions.smallest(20)),
                  ),
                ),
                child: Center(
                  child: BigText(text: product.name!, size: 26,)),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: Dimensions.height(300),
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
                placeholder: (context, url) => const CircularProgressIndicator(color: AppColors.mainColor),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.width(20),
                    right: Dimensions.width(20),
                  ),
                  child: ExpandableText(text: product.description!),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width(50),
              right: Dimensions.width(50),
              top: Dimensions.height(10),
              bottom: Dimensions.height(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppIcon(
                  icon: Icons.remove,
                  backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  iconSize: 24),
                BigText(
                  text: "\$${product.price!} x 0",
                  color: AppColors.mainBlackColor,
                  size: 26,
                ),
                const AppIcon(
                  icon: Icons.add,
                  backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  iconSize: 24,
                ),
              ],
            ),
          ),
          Container(
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
                  child: Icon(
                    Icons.favorite,
                    color: AppColors.mainColor,
                  )
                ),
                Container(
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
                  child: BigText(text: "\$10 | Add to cart", color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}