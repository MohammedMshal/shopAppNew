import 'package:flutter/material.dart';

const Color primaryColor = Color(0xffDB3022);
const Color backgroundLightColor = Color(0xffF9F9F9);
const Color errorLightModeColor = Color(0xffF01F0E);
const Color successLightModeColor = Color(0xff2AA952);
const Color saleHot = Color(0xffDB3022);
const Color myGrey = Color(0xff9B9B9B);
const Color myBlack = Color(0xff222222);
const Color myWight = Color(0xffFFFFFF);

const Color backgroundDarkColor = Color(0xff1E1F28);

ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    backgroundColor: backgroundDarkColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: backgroundDarkColor,
    ),
    scaffoldBackgroundColor: backgroundDarkColor,
    appBarTheme: const AppBarTheme(
      color: backgroundDarkColor,
    ),
    iconTheme: const IconThemeData(
      color: primaryColor,
    ) ,

    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 34.0, fontWeight: FontWeight.bold, color: Colors.white),
      titleMedium: TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
      bodyMedium: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
      bodySmall: TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
    ));

ThemeData lightTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      selectedLabelStyle: TextStyle(color: Colors.green),
      unselectedIconTheme: IconThemeData(color: myBlack),
      selectedItemColor: primaryColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor:Color(0xfffafafa),
      elevation: 0,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 34.0, fontWeight: FontWeight.bold, color: Colors.black),
      titleMedium: TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
      bodyMedium: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
      bodySmall: TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
    ));
