import 'package:coflowcase/costant.dart';
import 'package:coflowcase/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class SocalCard extends StatelessWidget {
  const SocalCard({
    Key key,
    this.icon,
    this.press,
  }) : super(key: key);

  final String icon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin:
        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10,context)),
        padding: EdgeInsets.all(getProportionateScreenWidth(12,context)),
        height: getProportionateScreenHeight(40,context),
        width: getProportionateScreenWidth(40,context),
        decoration: BoxDecoration(
          color: DefineColor.thirdColor,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}
