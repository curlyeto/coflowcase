import 'package:coflowcase/core/locator/get_it.dart';
import 'package:coflowcase/core/model/basket.dart';
import 'package:coflowcase/core/service/basket_base.dart';
import 'package:coflowcase/core/service/basket_service.dart';
import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
enum BasketViewState { Idle, Busy }
class BasketViewModel extends ChangeNotifier implements BasketBase{
  BasketViewState _state = BasketViewState.Idle;
  BasketService basketService=locator<BasketService>();
  List<Basket> _basketList=[];
  int _basket_count=0;


  BasketViewState get state => _state;
  int get basket_count => _basket_count;
  List<Basket> get basketList=>_basketList;


  set state(BasketViewState value) {
    _state = value;
    notifyListeners();
  }
  BasketViewModel(){
    getMyBasket();
  }
  @override
  Future<Response> addBasket(int product_id, double quantity) async{
    try {
      state = BasketViewState.Busy;
      _basket_count++;
      return await basketService.addBasket(product_id, quantity);
    } finally {
      state = BasketViewState.Idle;
    }
  }


  @override
  Future<List<Basket>> getMyBasket() async{
    try {
      state = BasketViewState.Busy;
      _basketList= await basketService.getMyBasket();
      if(_basketList!=null)
      _basket_count=_basketList.length;
      return _basketList;
    } finally {
      state = BasketViewState.Idle;
    }
  }
}