import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Pallete {
  // Colors
  static const blackColor = Color.fromRGBO(0, 0, 0, 1);
  static const appBarColor = Color.fromRGBO(0, 0, 0, 1);
  static const greyColor = Color.fromRGBO(13, 31, 35, 1);
  static const drawerColor = Color.fromRGBO(18, 18, 18, 1);
  static const whiteColor = Colors.white;
  static const redColor = Colors.red;
  static var blueColor = Colors.blue.shade300;
  static const loaderColor = Colors.white;
  static const imageColor = Colors.white;
  static const iconColor = Colors.white;
  static const textColor = Colors.white;
  static ThemeData darkTheme = ThemeData(
    primaryColor: Pallete.greyColor,
    scaffoldBackgroundColor: Pallete.blackColor,

    iconTheme: const IconThemeData(
      color: iconColor,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: appBarColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: blackColor,
        side: const BorderSide(width: 2.0, color: whiteColor),
      ),
    ),

    // font
    fontFamily: 'SpaceGrotesk',

    //text style
    textTheme: TextTheme(
        bodyLarge: TextStyle(
            fontSize: 23.sp,
            color: textColor,
            fontFamily: 'SpaceGrotesk',
            fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(
            fontSize: 17.sp,
            color: textColor,
            fontFamily: 'SpaceGrotesk',
            fontWeight: FontWeight.w400),
        bodySmall: TextStyle(
            fontSize: 13.sp,
            color: textColor,
            fontFamily: 'SpaceGrotesk',
            fontWeight: FontWeight.w400)),
  );
}
