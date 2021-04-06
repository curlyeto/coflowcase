import 'package:coflowcase/core/locator/get_it.dart';
import 'package:coflowcase/core/viewmodel/basket_viewmodel.dart';
import 'package:coflowcase/core/viewmodel/order_viewmodel.dart';
import 'package:coflowcase/core/viewmodel/product_viewmodel.dart';
import 'package:coflowcase/view/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/viewmodel/user_viewmodel.dart';

void main() {
  setuplocater();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coflowcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: appBarTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:MultiProvider(
        providers: [
          ChangeNotifierProvider<UserViewModel>( create:(context)=>UserViewModel(),),
          ChangeNotifierProvider<ProductViewModel>( create:(context)=>ProductViewModel(),),
          ChangeNotifierProvider<BasketViewModel>( create:(context)=>BasketViewModel(),),
          ChangeNotifierProvider<OrderViewModel>( create:(context)=>OrderViewModel(),),
        ],
        child: LandingPage(),
      ),
    );
  }
  AppBarTheme appBarTheme() {
    return AppBarTheme(
      color: Colors.white,
      elevation: 0,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.black),
      textTheme: TextTheme(
        headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
      ),
    );
  }
}

