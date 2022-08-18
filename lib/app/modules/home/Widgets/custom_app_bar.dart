
import 'package:flutter/material.dart';
import 'package:hive_getx/app/data/constants.dart';
import 'package:hive_getx/app/data/typography.dart';



class CustomAppBar extends StatelessWidget{
  final Widget leading;
  final String title;
  final List<Widget> action;
  const CustomAppBar({
    Key? key,
    required this.leading, required this.title, required this.action,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,


      actions: action,

      centerTitle: true,
      backgroundColor: CustomColor.kpendingyellow,
      title: Text(title,
        style: CustomTextStyle.kmediumTextStyle.copyWith(fontWeight: CustomFontWeight.kBoldFontWeight,color: CustomColor.kwhite ),
      ),);


  }
}
