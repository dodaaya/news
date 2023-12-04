import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryLight = Color(0xff39A552);
  static Color black = Color(0xff303030);
  static Color white = Color(0xffffffff);
  static Color greyColor = Color(0xff4F5A69);
  static Color pinkColor = Color(0xffED1E79);
  static Color blueColor = Color(0xff003E90);
  static Color redColor = Color(0xffC91C22);
  static Color yellowolor = Color(0xffF2D352);
  static Color orangeColor = Color(0xffCF7E48);
  static Color babyBlueColor = Color(0xff4882CF);
  static Color paragraphTitleColor = Color(0xff42505C);

  static ThemeData lightTheme = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
        activeIndicatorBorder: BorderSide.none,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
    appBarTheme: AppBarTheme(
        backgroundColor: primaryLight,
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)))),
    textTheme: TextTheme(
      titleLarge:
          TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: white),
      titleMedium:
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: black),
      titleSmall:
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: black),
    ),
  );
}
