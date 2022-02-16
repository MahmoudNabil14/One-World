import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.blue,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
        color: Colors.blue
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.blue
    ),
    titleTextStyle: TextStyle(
      fontFamily: 'Urial',
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: Colors.blue
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    unselectedLabelStyle: TextStyle(
      fontFamily: "Urial",
    ),
    selectedLabelStyle: TextStyle(
      fontFamily: "Urial",
      fontSize: 16.0,
    )
  )
);