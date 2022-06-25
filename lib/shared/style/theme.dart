import 'package:flutter/material.dart';


const Color primaryColor = Color(0xffDB3022);
const Color backgroundLightColor = Color(0xffF9F9F9);
const Color errorLightModeColor = Color(0xffF01F0E);
const Color successLightModeColor = Color(0xff2AA952);
const Color saleHot = Color(0xffDB3022);
const Color grey = Color(0xff9B9B9B);
const Color black = Color(0xff222222);

const Color backgroundDarkColor = Color(0xff1E1F28);


ThemeData darkTheme = ThemeData(
  primaryColor: primaryColor,
  backgroundColor: backgroundDarkColor,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primaryColor ,
      unselectedItemColor: Colors.white
  ),
  scaffoldBackgroundColor: backgroundDarkColor,
);

ThemeData lightTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      selectedLabelStyle: TextStyle(
        color: Colors.green
      ),
      unselectedIconTheme: IconThemeData(
        color: black
      ),
        selectedItemColor: primaryColor
      ,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      elevation: 0,
    ),
    scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    titleMedium: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,color: Colors.black),
    bodyMedium: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.black) ,
    bodySmall: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,color: Colors.black) ,
  )

);