import 'package:coflowcase/core/locator/get_it.dart';
import 'package:coflowcase/core/model/products.dart';
import 'package:coflowcase/core/service/product_base.dart';
import 'package:coflowcase/core/service/product_service.dart';
import 'package:flutter/cupertino.dart';

enum ProductViewState { Idle, Busy }
class ProductViewModel extends ChangeNotifier implements ProductBase{
  ProductService productService=locator<ProductService>();
  List<Product> _productList=[];
  ProductViewState _state = ProductViewState.Idle;
  List<Product> get productList=>_productList;
  ProductViewState get state => _state;

  set state(ProductViewState value) {
    _state = value;
    notifyListeners();
  }
  ProductViewModel(){
    getProducts();
  }


  @override
  Future<List<Product>> getProducts() async{
    try {
      state = ProductViewState.Busy;
      _productList= await productService.getProducts();
      return _productList;
    } finally {
      state = ProductViewState.Idle;
    }
  }

}