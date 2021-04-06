import 'package:coflowcase/costant.dart';
import 'package:coflowcase/size_config.dart';
import 'package:flutter/material.dart';



class CustomAppBar extends PreferredSize {
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20,context)),
        child: Row(
          children: [
            SizedBox(
              height: getProportionateScreenWidth(40,context),
              width: getProportionateScreenWidth(40,context),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                color: Colors.white,
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back),
              ),
            ),
            Text(
              DefineText.detailProduct,
              style: TextStyle(color: Colors.black,fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
