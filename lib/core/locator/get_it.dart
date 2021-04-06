import 'package:coflowcase/core/service/basket_service.dart';
import 'package:coflowcase/core/service/order_service.dart';
import 'package:coflowcase/core/service/product_service.dart';
import 'package:coflowcase/core/service/user_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
void setuplocater(){
  locator.registerLazySingleton(()=>UserService());
  locator.registerLazySingleton(()=>ProductService());
  locator.registerLazySingleton(()=>BasketService());
  locator.registerLazySingleton(()=>OrderService());
}