import 'package:coflowcase/core/viewmodel/user_viewmodel.dart';
import 'package:coflowcase/costant.dart';
import 'package:coflowcase/view/homepage.dart';
import 'package:coflowcase/view/login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final _authModel=Provider.of<UserViewModel>(context);
    if(_authModel.state==ViewState.Idle){
      if(_authModel.user==null){
        return Login();
      }else{
        return HomePage();
      }
    }else{
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(DefineImages.logo),
                SizedBox(height: 10,),
                Lottie.asset(DefineLottie.lottie)
              ],
            ),
          ),
        ),
      );
    }


  }
}
