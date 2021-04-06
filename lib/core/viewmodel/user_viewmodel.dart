import 'package:coflowcase/core/locator/get_it.dart';
import 'package:coflowcase/core/model/orders.dart';
import 'package:coflowcase/core/model/user.dart';
import 'package:coflowcase/core/service/user_base.dart';
import 'package:coflowcase/core/service/user_service.dart';
import 'package:flutter/cupertino.dart';

enum ViewState { Idle, Busy }
class UserViewModel extends ChangeNotifier implements UserBase{
  UserService userService=locator<UserService>();
  User _user;
  ViewState _state = ViewState.Idle;
  List<Orders> _orderList=[];
  List<Orders> get orderList=>_orderList;
  User get user => _user;
  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }
  set user(User value) {
    _user = value;
  }
  UserViewModel(){
    currentUser();
  }

  @override
  Future<dynamic> signIn(String username, String password) async{
    try {
      state = ViewState.Busy;
      return  await userService.signIn(username, password);
    } finally {
      state = ViewState.Idle;
    }
  }


  @override
  Future<User> currentUser() async{
    try {
      state = ViewState.Busy;
      _user = await userService.currentUser();
      if (_user != null)
        return _user;
    }  finally {
      state = ViewState.Idle;
    }
  }




}