import 'package:coflowcase/core/model/user.dart';
import 'package:coflowcase/core/viewmodel/user_viewmodel.dart';
import 'package:coflowcase/costant.dart';
import 'package:coflowcase/size_config.dart';
import 'package:coflowcase/view/component/default_button.dart';
import 'package:coflowcase/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool remember=false;

  Future<void> getFormData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('username')!=null){
      remember=true;
      usernameController.text = prefs.getString('username');
      passwordController.text = prefs.getString('password');
    }

    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFormData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0,context)),
                  child: Image.asset(DefineImages.logo),
                ),
                SizedBox(height: getProportionateScreenHeight(20,context)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Form(
                    key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: usernameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return DefineText.usernameNotNull;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: DefineText.username,
                              hintText: DefineText.enterUsername,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              suffixIcon: Padding(
                                padding: EdgeInsets.fromLTRB(
                                  0,
                                  getProportionateScreenWidth(20.0,context),
                                  getProportionateScreenWidth(20.0,context),
                                  getProportionateScreenWidth(20.0,context),
                                ),
                                child: Container(
                                  height: getProportionateScreenWidth(18.0,context),
                                  child: Icon(
                                      Icons.person_outline,
                                      color: Colors.black38,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(30.0,context)),
                          TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return DefineText.passNotNull;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: DefineText.pass,
                              hintText: DefineText.enterPass,
                              // If  you are using latest version of flutter then lable text and hint text shown like this
                              // if you r using flutter less then 1.20.* then maybe this is not working properly
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              suffixIcon: Padding(
                                padding: EdgeInsets.fromLTRB(
                                  0,
                                  getProportionateScreenWidth(20,context),
                                  getProportionateScreenWidth(20,context),
                                  getProportionateScreenWidth(20,context),
                                ),
                                child: SvgPicture.asset(
                                  DefineSvg.loginPass,
                                  height: getProportionateScreenWidth(18,context),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20,context)),
                          Row(
                            children: [
                              Checkbox(
                                value: remember,
                                activeColor: DefineColor.primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    remember = value;
                                  });
                                },
                              ),
                              Text(DefineText.rememberMe),
                            ],
                          ),
                          DefaultButton(
                            text: DefineText.signIn,
                            press: (){
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                signIn(context);

                              }
                            },
                          ),
                        ],
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> signIn(BuildContext context) async{
    UserViewModel userViewModel=Provider.of<UserViewModel>(context,listen: false);
    var response=await userViewModel.signIn(usernameController.text, passwordController.text);
    if(response['result_code']=="1"){
      User user= await userViewModel.currentUser();
     if(remember){
       SharedPreferences prefs = await SharedPreferences.getInstance();
       prefs.setString('username', usernameController.text);
       prefs.setString('password', passwordController.text);
     }
      Fluttertoast.showToast(
          msg: response['result_desc'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=>HomePage()
      ));
    }else{
      Fluttertoast.showToast(
          msg: response['result_desc'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}
