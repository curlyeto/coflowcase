import 'package:coflowcase/core/model/basket.dart';
import 'package:coflowcase/core/model/sendorders.dart';
import 'package:coflowcase/core/viewmodel/basket_viewmodel.dart';
import 'package:coflowcase/core/viewmodel/order_viewmodel.dart';
import 'package:coflowcase/costant.dart';
import 'package:coflowcase/size_config.dart';
import 'package:coflowcase/view/component/default_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  final BasketViewModel basketViewModel;

  const CartScreen({Key key,this.basketViewModel}) : super(key: key);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalPrice=0.0;
  List<Basket> basketList=[];
  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BasketViewModel>( create:(context)=>BasketViewModel(),),
        ChangeNotifierProvider<OrderViewModel>( create:(context)=>OrderViewModel(),),
      ],
      child: Consumer<BasketViewModel>(
        builder: (context,model,_){
          basketList=model.basketList;
          if(model.state==BasketViewState.Busy){
            return Scaffold(
              body: Center(child: CircularProgressIndicator(),),
            );
          }else{
            if(basketList.length==0){
              return Scaffold(body: Center(child: Text(DefineText.noItemsCart),),);
            }
            return Scaffold(
              appBar: buildAppBar(context),
              bottomNavigationBar: bottomBar(context),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20,context)),
                child: ListView.builder(
                  itemCount: basketList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 88,
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: Container(
                              padding: EdgeInsets.all(getProportionateScreenWidth(10,context)),
                              decoration: BoxDecoration(
                                color: DefineColor.thirdColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Image.network(basketList[index].images[0]),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              basketList[index].title,
                              style: TextStyle(color: Colors.black, fontSize: 10),
                              maxLines: 2,
                            ),
                            SizedBox(height: 10),
                            Text.rich(
                              TextSpan(
                                text: "${basketList[index].price} TL",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, color: DefineColor.primaryColor),
                                children: [
                                  TextSpan(
                                      text: " x${basketList[index].count}",
                                      style: Theme.of(context).textTheme.bodyText1),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            DefineText.myCart,
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${basketList.length} ürün",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
  Widget bottomBar(BuildContext context) {
    for(int i=0;i<basketList.length;i++){
      totalPrice+=basketList[i].price;
    }
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15,context),
        horizontal: getProportionateScreenWidth(30,context),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: DefineColor.fourthColor.withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: DefineText.cartTotal,
                    children: [
                      TextSpan(
                        text: "${totalPrice.toStringAsFixed(3)} TL",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190,context),
                  child: DefaultButton(
                    text: DefineText.order,
                    press: ()=>addOrder(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

 Future<void> addOrder(BuildContext context) async{
    List<SendOrder> senderOrderList=[];
    for(int i=0;i<basketList.length;i++){
      senderOrderList.add(SendOrder(basketList[i].id,basketList[i].price));
    }
    SendOrders sendOrders=SendOrders(senderOrderList);
    Response response= await Provider.of<OrderViewModel>(context,listen: false).addOrder(totalPrice, sendOrders.toJson()['oderItems']);
    if(response.data['result_code']=="1"){
      Fluttertoast.showToast(
          msg: response.data['result_desc'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.of(context).pop();
    }else{
      Fluttertoast.showToast(
          msg: response.data['result_desc'],
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

