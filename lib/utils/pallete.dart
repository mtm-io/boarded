import 'package:flutter/material.dart';

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

    // font
    fontFamily: 'SpaceGrotesk',
    //text style
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
          fontSize: 23,
          color: Colors.white,
          fontFamily: 'SpaceGrotesk',
          fontWeight: FontWeight.w500),
    ),
  );
}
