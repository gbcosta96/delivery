import 'package:delivery/data/repository/cart_repo.dart';
import 'package:delivery/models/cart_model.dart';
import 'package:delivery/models/products_model.dart';
import 'package:delivery/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  void addItem(ProductModel product, int quantity){
    if(_items.containsKey(product.id!)){
      var totalQuantity = 0;
      _items.update(product.id!, (value) {
        value.quantity = value.quantity! + quantity;
        totalQuantity = value.quantity!;
        return value;
      });

      if(totalQuantity <= 0){
        _items.remove(product.id!);
      }
    }
    else if(quantity > 0) {
      _items.putIfAbsent(product.id!, () => CartModel(
        id: product.id,
        name: product.name,
        price: product.price,
        img: product.img,
        quantity: quantity,
        isExist: true,
        time: DateTime.now().toString(),
      ));  
    }
    else{
      Get.snackbar(
        "Item count", "You should at least add an item in the cart!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
    }
  }

  bool existInCart(ProductModel product){
    return _items.containsKey(product.id);
  }

  int getQuantity(ProductModel product){
    if(_items.containsKey(product.id!)){
      return _items[product.id!]?.quantity ?? 0;
    }
    return 0;
  }

  int get totalItems{
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems{
    return _items.entries.map((e) => e.value).toList();
  }  
}