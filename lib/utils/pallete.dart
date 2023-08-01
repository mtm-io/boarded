import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Pallete {
  // Colors
  static const blackColor = Color.fromRGBO(0, 0, 0, 1); // primary color
  static const greyColor = Color.fromRGBO(26, 39, 45, 1); // secondary color
  static const drawerColor = Color.fromRGBO(18, 18, 18, 1);
  static const whiteColor = Colors.white;
  static var redColor = Colors.red.shade500;
  static var blueColor = Colors.blue.shade300;

  static ThemeData darkTheme = ThemeData(
    primaryColor: Pallete.greyColor,
    scaffoldBackgroundColor: Pallete.blackColor,

    iconTheme: const IconThemeData(
      color: whiteColor,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: blackColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: blackColor,
        side: const BorderSide(
          width: 2.0,
          color: whiteColor,
        ),
      ),
    ),

    // font
    fontFamily: 'SpaceGrotesk',
    //text style
    textTheme: TextTheme(
      bodyMedium: TextStyle(
          fontSize: 23.sp,
          color: Colors.white,
          fontFamily: 'SpaceGrotesk',
          fontWeight: FontWeight.w400),
    ),
  );
}
