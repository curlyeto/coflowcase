import 'package:coflowcase/core/costant.dart';
import 'package:coflowcase/core/model/basket.dart';
import 'package:coflowcase/core/model/baskets.dart';
import 'package:coflowcase/core/service/basket_base.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasketService implements BasketBase{
  @override
  Future<Response> addBasket(int product_id, double quantity) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('userid');
    try{
      FormData formData = FormData.fromMap({
        "user_id":userid,
        "product_id":product_id,
        "quantity":quantity,
      });
      Response response = await Dio().post(DefineApiCostant.baseUrl+"user/addbasket", data: formData);
      if(response.statusCode==201){
        return response;
      }
    } catch(e){
      print("Basket Service addBasket hata ${e.toString()}");
      return null;
    }
  }

  @override
  Future<List<Basket>> getMyBasket() async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int user_id = prefs.getInt('userid');
      Response response = await Dio().get(DefineApiCostant.baseUrl+"user/getmybasket/$user_id");
      print("RESPONSE ${response.data}");
      Baskets baskets=Baskets.fromJsonMap(response.data);
      return baskets.baskets;
    }catch(e){
      print("Basket Service getMyBasket hata ${e.toString()}");
      return null;
    }
  }

}