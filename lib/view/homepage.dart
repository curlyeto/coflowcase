import 'package:coflowcase/core/model/products.dart';
import 'package:coflowcase/core/viewmodel/basket_viewmodel.dart';
import 'package:coflowcase/core/viewmodel/order_viewmodel.dart';
import 'package:coflowcase/core/viewmodel/product_viewmodel.dart';
import 'package:coflowcase/costant.dart';
import 'package:coflowcase/size_config.dart';
import 'package:coflowcase/view/cartscreen.dart';
import 'package:coflowcase/view/component/iconbuttoncounter.dart';
import 'package:coflowcase/view/myorders.dart';
import 'package:coflowcase/view/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> productList=[];
  List<Product> _searchResult=[];
  ScrollController scrollController=new ScrollController();
  ScrollController scrollController1=new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ProductViewModel>(
          builder: (context,model,_){
            productList=model.productList;
            if(model.state==ProductViewState.Busy){
              return Scaffold(
                body: Center(child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(DefineText.loadingData,style: TextStyle(fontSize: 20),),
                      SizedBox(height: 10,),
                      CircularProgressIndicator()
                    ],
                  ),),
              );
            }else{
              if(productList.length==0){
                return Scaffold(body: Center(child: Text(DefineText.noProduct),),);
              }
              return bodyWidgets(context);
            }
          },
        ),
      ),
    );
  }
  Widget bodyWidgets(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20,context)),
          homeHeader(context),
          SizedBox(height: getProportionateScreenHeight(20,context)),
          SearchField(context),
          SizedBox(height: getProportionateScreenWidth(10,context)),
          _searchResult.length>0?bodyList(context,_searchResult):bodyList(context,productList)
        ],
      ),
    );
  }

  Widget bodyList(BuildContext context, List<Product> list){
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1.6/ 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: list.length,
        controller: scrollController1,
        shrinkWrap: true,
        itemBuilder: (context,index){
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10,context)),
            child: SizedBox(
              width: getProportionateScreenWidth(140,context),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context)=>ProductDetails(product: list[index],)
                      )
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.02,
                      child: Container(
                        padding: EdgeInsets.all(getProportionateScreenWidth(15,context)),
                        decoration: BoxDecoration(
                          color: DefineColor.secondColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Hero(
                          tag: list[index].id.toString(),
                          child: Image.network(list[index].images[0]),
                        ),
                      ),
                    ),
                    Text(
                      list[index].title,
                      style: TextStyle(color: Colors.black),
                      maxLines: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${list[index].price} TL",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18,context),
                            fontWeight: FontWeight.w600,
                            color: DefineColor.primaryColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  Widget homeHeader(BuildContext context){
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20,context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Image.asset(DefineImages.logo),
          ),
          Consumer<BasketViewModel>(
            builder: (context,model,_){
              return IconBtnWithCounter(
                svgSrc: DefineSvg.homeCart,
                press: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context)=>CartScreen(basketViewModel: model,)
                      )
                  );
                },
              );
            },
          ),
          Consumer<OrderViewModel>(
            builder: (context,model,_){
              return  IconBtnWithCounter(
                svgSrc: DefineSvg.homeOrder,
                color: Colors.black38,
                press: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context)=>MyOrders(ordersList: model.orderList,)
                      )
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget SearchField(BuildContext context){
   return Container(
     width: MediaQuery.of(context).size.width * 0.9,
     decoration: BoxDecoration(
       color: DefineColor.secondColor.withOpacity(0.1),
       borderRadius: BorderRadius.circular(15),
     ),
     child: TextField(
       onChanged: onSearchTextChanged,
       decoration: InputDecoration(
           contentPadding: EdgeInsets.symmetric(
               horizontal: getProportionateScreenWidth(20,context),
               vertical: getProportionateScreenWidth(9,context)),
           border: InputBorder.none,
           focusedBorder: InputBorder.none,
           enabledBorder: InputBorder.none,
           hintText: DefineText.searchProduct,
           prefixIcon: Icon(Icons.search)),
     ),
   );
  }

  void onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    productList.forEach((userDetail) {
      String title=userDetail.title.toLowerCase();
      String word=text.toLowerCase();
      if (title.contains(word))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }



}
