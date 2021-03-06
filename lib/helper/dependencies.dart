import 'package:delivery/data/api/api_client.dart';
import 'package:delivery/data/controllers/cart_controller.dart';
import 'package:delivery/data/controllers/popular_product_controller.dart';
import 'package:delivery/data/controllers/recommended_product_controller.dart';
import 'package:delivery/data/repository/cart_repo.dart';
import 'package:delivery/data/repository/popular_product_repo.dart';
import 'package:delivery/data/repository/recommended_product_repo.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:get/get.dart';

Future<void> init() async {
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL), fenix: true);
  
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()), fenix: true);
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()), fenix: true);
  Get.lazyPut(() => CartRepo(), fenix: true);

  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()), fenix: true);
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()), fenix: true);
  Get.lazyPut(() => CartController(cartRepo: Get.find()), fenix: true);
}