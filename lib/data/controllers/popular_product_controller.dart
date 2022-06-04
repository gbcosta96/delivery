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
    /*Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode == 200){
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    }
    else{
      //print("Error: ${response.statusText}");
    }*/
    _popularProductList = [
      ProductModel(id: 1, name: "Empresa1", description: "blablablablalbasoadokasoad", price: 0, stars: 4, 
      img:"https://img.freepik.com/fotos-gratis/imagem-aproximada-em-tons-de-cinza-de-uma-aguia-careca-americana-em-um-fundo-escuro_181624-31795.jpg?w=2000",
      location: "Brasil", created_at: "2022-06-04 12:46:00", updated_at:"2022-06-04 12:46:00", type_id: 2),
      ProductModel(id: 2, name: "Empresa2", description: "blablablablalbasoadokasoad", price: 0, stars: 4, 
      img:"https://img.freepik.com/fotos-gratis/3d-rendem-de-uma-mesa-de-madeira-com-uma-imagem-defocussed-de-um-barco-em-um-lago_1048-3432.jpg?w=2000",
      location: "Brasil", created_at: "2022-06-04 12:46:00", updated_at:"2022-06-04 12:46:00", type_id: 2),
      ProductModel(id: 3, name: "Empresa3", description: "blablablablalbasoadokasoad", price: 0, stars: 4, 
      img:"https://veja.abril.com.br/wp-content/uploads/2019/12/amazonia-floresta-coraccca7ao.jpg.jpg",
      location: "Brasil", created_at: "2022-06-04 12:46:00", updated_at:"2022-06-04 12:46:00", type_id: 2),
    ];
    _isLoaded = true;
    update();
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