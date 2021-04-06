import 'package:coflowcase/core/model/order.dart';
import 'package:coflowcase/costant.dart';
import 'package:coflowcase/size_config.dart';
import 'package:flutter/material.dart';

class MyOrdersDetail extends StatefulWidget {
  final List<Order> orderList;

  const MyOrdersDetail({Key key, this.orderList}) : super(key: key);
  @override
  _MyOrdersDetailState createState() => _MyOrdersDetailState();
}

class _MyOrdersDetailState extends State<MyOrdersDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20,context)),
        child: ListView.builder(
          itemCount: widget.orderList.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: AspectRatio(
                aspectRatio: 0.88,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(widget.orderList[index].image),
                ),
              ),
              title:Text(
                widget.orderList[index].title,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              subtitle: Text(
                "${widget.orderList[index].price} TL",
                style: TextStyle(fontWeight: FontWeight.w600, color: DefineColor.primaryColor),
              ),
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
            DefineText.myOrdersDetail,
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${widget.orderList.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }

}
