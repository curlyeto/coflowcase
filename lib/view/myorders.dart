import 'package:coflowcase/core/model/orders.dart';
import 'package:coflowcase/core/viewmodel/order_viewmodel.dart';
import 'package:coflowcase/costant.dart';
import 'package:coflowcase/size_config.dart';
import 'package:coflowcase/view/my_orders_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget {
  final List<Orders> ordersList;

  const MyOrders({Key key, this.ordersList}) : super(key: key);
  @override
  _MyOrdersState createState() => _MyOrdersState();
}




class _MyOrdersState extends State<MyOrders> {
  List<Orders> orders=[];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>OrderViewModel(),
      child: Consumer<OrderViewModel>(
        builder: (context,model,_){
          orders=model.orderList;
          if(model.state==OrderViewState.Busy){
            return Scaffold(
              body: Center(child: CircularProgressIndicator(),),
            );
          }else{
            if(orders.length==0){
              return Scaffold(body: Center(child: Text(DefineText.noOrder),),);
            }
            return Scaffold(
              appBar: buildAppBar(context),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20,context)),
                child: myOrdersList(),
              ),
            );
          }

        },
      ),
    );
  }


  Widget myOrdersList(){
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: (){
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context)=>MyOrdersDetail(orderList: orders[index].order_products,)
              )
          );
        },
        child: Card(
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(orders[index].order_date,style: TextStyle(
                            fontSize: 15
                        ),),
                        SizedBox(height: 5,),
                        Text("${orders[index].order_quantity} TL"),
                      ],
                    ),
                    Row(
                      children: [
                        Text(DefineText.orderItemDetail,style:TextStyle(
                            color: DefineColor.primaryColor,
                            fontSize: 15
                        ),),
                        Icon(Icons.arrow_right,color: DefineColor.primaryColor,size: 25,)
                      ],
                    )

                  ],
                ),
                Divider(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...List.generate(orders[index].product_images.length,
                                (i) => Container(
                              width: getProportionateScreenWidth(65,context),
                              height: getProportionateScreenHeight(100,context),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.network(orders[index].product_images[i]),
                            )
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(8,context),),
                    Text("${orders[index].order_count} Ürün şipariş edildi")

                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }


  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            DefineText.myOrders,
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${orders.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
