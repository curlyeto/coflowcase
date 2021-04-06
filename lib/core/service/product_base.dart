import 'package:coflowcase/core/model/products.dart';

abstract class ProductBase{
  Future<List<Product>> getProducts();
}