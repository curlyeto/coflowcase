import 'package:coflowcase/core/model/user.dart';

abstract class UserBase{
  Future<dynamic> signIn(String username,String password);
  Future<User> currentUser();
}