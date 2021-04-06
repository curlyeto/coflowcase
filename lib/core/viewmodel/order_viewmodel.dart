import 'package:coflowcase/core/locator/get_it.dart';
import 'package:coflowcase/core/model/orders.dart';
import 'package:coflowcase/core/service/order_base.dart';
import 'package:coflowcase/core/service/order_service.dart';
import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';

enum OrderViewState { Idle, Busy }
class OrderViewModel extends ChangeNotifier implements OrderBase{
  OrderService orderService=locator<OrderService>();
  OrderViewState _state = OrderViewState.Idle;
  List<Orders> _orderList=[];
  List<Orders> get orderList=>_orderList;
  OrderViewState get state => _state;
  set state(OrderViewState value) {
    _state = value;
    notifyListeners();
  }
  OrderViewModel(){
    getMyOrders();
  }
  @override
  Future<List<Orders>> getMyOrders() async{
    try {
      state = OrderViewState.Busy;
      _orderList=await orderService.getMyOrders();
      return _orderList;
    } finally {
      state = OrderViewState.Idle;
    }
  }
  @override
  Future<Response> addOrder(double oreder_quantitiy, List<Map<String, dynamic>> sendOrderList) async{
    try {
      state = OrderViewState.Busy;
      return await orderService.addOrder(oreder_quantitiy,sendOrderList);
    } finally {
      state = OrderViewState.Idle;
    }
  }
}