import 'package:coflowcase/core/model/basket.dart';
import 'package:dio/dio.dart';

abstract class BasketBase{
  Future<Response> addBasket(int product_id,double quantity);
  Future<List<Basket>> getMyBasket();
}