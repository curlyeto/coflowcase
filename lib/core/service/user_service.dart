import 'package:coflowcase/core/costant.dart';
import 'package:coflowcase/core/model/user.dart';
import 'package:coflowcase/core/service/user_base.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService implements UserBase{
  @override
  Future<User> currentUser() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int user_id = prefs.getInt('userid');
      print("User id "+user_id.toString());
      print(DefineApiCostant.baseUrl+"user/info/$user_id");
      if(user_id!=null){
        Response response = await Dio().get(DefineApiCostant.baseUrl+"user/info/$user_id");
        return User.fromJsonMap(response.data);
      }
  }

  @override
  Future<dynamic> signIn(String username, String password) async{
    try{
      FormData formData = FormData.fromMap({
        "username": username,
        "password":password,
      });
      Response response = await Dio().post(DefineApiCostant.baseUrl+"user/login", data: formData);
      print(response);
      if(response.statusCode==200 && response.data['result_code']=="1"){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('userid', response.data['user_id']);
        return response.data;
      }
    } catch(e){
      print(e.toString());
    }
  }

}