import 'package:coflowcase/core/model/orders.dart';
import 'package:dio/dio.dart';

abstract class OrderBase{
  Future<Response> addOrder(double oreder_quantitiy,List<Map<String, dynamic>> sendOrderList);
  Future<List<Orders>> getMyOrders();
}