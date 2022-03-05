import 'package:delivery/data/controllers/cart_controller.dart';
import 'package:delivery/data/repository/popular_product_repo.dart';
import 'package:delivery/models/cart_model.dart';
import 'package:delivery/models/products_model.dart';
import 'package:delivery/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;


  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode == 200){
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    }
    else{
      //print("Error: ${response.statusText}");
    }
  }

  void setQuantity(bool isIncrement){
    _quantity = isIncrement ? checkQuantity(_quantity + 1) : checkQuantity(_quantity - 1);
    print(_quantity);
    update();
  }
  int checkQuantity(int quantity){
    if((_inCartItems + quantity) < 0){
      Get.snackbar(
        "Item count", "You can't reduce more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return -_inCartItems;
    }
    else if((_inCartItems + quantity) > 20){
      Get.snackbar(
        "Item count", "You can't add more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20 - _inCartItems;
    }
    return quantity;
  }
  void initProduct(ProductModel product, CartController cart){
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    if(_cart.existInCart(product)){
      _inCartItems = _cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product){
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print("key $key, quantity ${value.quantity}");
    });
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }
  
  List<CartModel> get getItems{
    return _cart.getItems;
  }
}