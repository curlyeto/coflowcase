import 'package:coflowcase/core/model/products.dart';
import 'package:coflowcase/core/viewmodel/basket_viewmodel.dart';
import 'package:coflowcase/costant.dart';
import 'package:coflowcase/size_config.dart';
import 'package:coflowcase/view/component/custom_appbar.dart';
import 'package:coflowcase/view/component/default_button.dart';
import 'package:coflowcase/view/component/product_description.dart';
import 'package:coflowcase/view/component/product_images.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({Key key, this.product}) : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>BasketViewModel(),
      child: Scaffold(
        appBar: CustomAppBar(),
        bottomNavigationBar: bottomBar1(context),
        body: ListView(
          children: [
            ProductImages(product: widget.product),
            SizedBox(height: getProportionateScreenHeight(40,context),),
            ProductDescription(
              product: widget.product,
              pressOnSeeMore: () {},
            ),
            // bottomBar(),
          ],
        ),
      ),
    );
  }

  Widget bottomBar1(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<BasketViewModel>(builder: (context, model, _) {
              return DefaultButton(
                text: DefineText.addToCart,
                press: () => addtoCart(model, context),
              );
            })
          ],
        ),
      ),
    );
  }



  Future<void> addtoCart(BasketViewModel model, BuildContext context) async{
    Response response= await model.addBasket(widget.product.id, widget.product.price);
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
