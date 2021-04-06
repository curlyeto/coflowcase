import 'package:coflowcase/core/costant.dart';
import 'package:coflowcase/core/model/orders.dart';
import 'package:coflowcase/core/service/order_base.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderService implements OrderBase{
  @override
  Future<List<Orders>> getMyOrders() async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int user_id = prefs.getInt('userid');
      Response response = await Dio().get(DefineApiCostant.baseUrl+"user/myorders/$user_id");
      OrderList orderList=OrderList.fromJsonMap(response.data);
      return orderList.orders;
    }catch(e){
      print("Order Service getMyOrders hata ${e.toString()}");
      return null;
    }
  }

  @override
  Future<Response> addOrder(double oreder_quantitiy, List<Map<String, dynamic>> sendOrderList) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int user_id = prefs.getInt('userid');
      var data={
        'user_id': user_id,
        'order_quantity': oreder_quantitiy,
        'oderItems':sendOrderList
      };
      Response response = await Dio().post(DefineApiCostant.baseUrl+"user/addorder",data: data);
      if(response.statusCode==201){
        return response;
      }
    }catch(e){
      print("Order Service addOrder hata ${e.toString()}");
      return null;
    }
  }

}