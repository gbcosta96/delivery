import 'package:delivery/data/repository/recommended_product_repo.dart';
import 'package:delivery/models/products_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    /*Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode == 200){
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    }
    else{
      //print("Error: ${response.statusText}");
    }*/
    _recommendedProductList = [
      ProductModel(id: 1, name: "Empresa4", description: "blablablablalbasoadokasoad", price: 0, stars: 4, 
      img:"https://img.freepik.com/fotos-gratis/imagem-aproximada-em-tons-de-cinza-de-uma-aguia-careca-americana-em-um-fundo-escuro_181624-31795.jpg?w=2000",
      location: "Brasil", created_at: "2022-06-04 12:46:00", updated_at:"2022-06-04 12:46:00", type_id: 2),
      ProductModel(id: 2, name: "Empresa5", description: "blablablablalbasoadokasoad", price: 0, stars: 4, 
      img:"https://img.freepik.com/fotos-gratis/3d-rendem-de-uma-mesa-de-madeira-com-uma-imagem-defocussed-de-um-barco-em-um-lago_1048-3432.jpg?w=2000",
      location: "Brasil", created_at: "2022-06-04 12:46:00", updated_at:"2022-06-04 12:46:00", type_id: 2),
      ProductModel(id: 3, name: "Empresa6", description: "blablablablalbasoadokasoad", price: 0, stars: 4, 
      img:"https://veja.abril.com.br/wp-content/uploads/2019/12/amazonia-floresta-coraccca7ao.jpg.jpg",
      location: "Brasil", created_at: "2022-06-04 12:46:00", updated_at:"2022-06-04 12:46:00", type_id: 2),
    ];
    _isLoaded = true;
    update();
  }
}