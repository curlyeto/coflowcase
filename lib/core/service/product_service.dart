import 'package:coflowcase/core/costant.dart';
import 'package:coflowcase/core/model/products.dart';
import 'package:coflowcase/core/service/product_base.dart';
import 'package:dio/dio.dart';

class ProductService implements ProductBase{
  @override
  Future<List<Product>> getProducts() async{
    try{
      var response = await Dio().get(DefineApiCostant.baseUrl+"product/products");
      Products products=Products.fromJsonMap(response.data);
      return products.products;
    }catch(e){
      print("Product Service getProducts hata ${e.toString()}");
      return null;
    }
  }

}