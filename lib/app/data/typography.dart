import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyle {
  static TextStyle get kVeryLargerTextStyle =>
      GoogleFonts.inter(textStyle: TextStyle(fontSize: ScreenUtil().setSp(24)));
  static TextStyle get kLargeStyle =>
      GoogleFonts.inter(textStyle: TextStyle(fontSize: ScreenUtil().setSp(40)));
  static TextStyle get kverybigStyle =>
      GoogleFonts.inter(textStyle: TextStyle(fontSize: ScreenUtil().setSp(18)));
  static TextStyle get kbigStyle =>
      GoogleFonts.inter(textStyle: TextStyle(fontSize: ScreenUtil().setSp(32)));
  static TextStyle get kmedhighTextStyle =>
      GoogleFonts.inter(textStyle: TextStyle(fontSize: ScreenUtil().setSp(28)));
  static TextStyle get kmediumTextStyle =>
      GoogleFonts.inter(textStyle: TextStyle(fontSize: ScreenUtil().setSp(24)));
  static TextStyle get khighmidTextStyle =>
      GoogleFonts.inter(textStyle: TextStyle(fontSize: ScreenUtil().setSp(22)));
  static TextStyle get kmedTextStyle =>
      GoogleFonts.inter(textStyle: TextStyle(fontSize: ScreenUtil().setSp(20)));
  static TextStyle get ktextTextStyle =>
      GoogleFonts.inter(textStyle: TextStyle(fontSize: ScreenUtil().setSp(16)));
  static TextStyle get ksearchTextStyle =>
      GoogleFonts.inter(textStyle: TextStyle(fontSize: ScreenUtil().setSp(14)));
  static TextStyle get ksmallTextStyle =>
      GoogleFonts.inter(textStyle: TextStyle(fontSize: ScreenUtil().setSp(12)));
  static TextStyle get kverysmallTextStyle =>
      GoogleFonts.inter(textStyle: TextStyle(fontSize: ScreenUtil().setSp(10)));
}

class CustomFontWeight {
  static FontWeight kThinFontWeight = FontWeight.w100;
  static FontWeight kExtraLightFontWeight = FontWeight.w200;
  static FontWeight kLightFontWeight = FontWeight.w300;
  static FontWeight kRegularWeight = FontWeight.w400;
  static FontWeight kMediumFontWeight = FontWeight.w500;
  static FontWeight kSemiBoldFontWeight = FontWeight.w600;
  static FontWeight kBoldFontWeight = FontWeight.w700;
  static FontWeight kExtraBoldFontWeight = FontWeight.w800;
  static FontWeight kBlackFontWeight = FontWeight.w900;
}

List<BoxShadow> boxshadow = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.1),
    spreadRadius: 10,
    blurRadius: 20,
    offset: const Offset(1, 1), // changes position of shadow
  )
];
