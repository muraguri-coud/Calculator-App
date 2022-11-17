// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  appBarTheme: AppBarTheme(backgroundColor: Color.fromARGB(255, 20, 115, 217) ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.black),

  cardTheme: CardTheme(surfaceTintColor: Colors.purple,elevation: 10),
  
  iconTheme: IconThemeData(
      color: Colors.black,
    ),
    primaryColor: Color.fromARGB(255, 20, 115, 217),
    listTileTheme: ListTileThemeData(
      
      tileColor: Color(0xffe8e8e8),
      textColor: Colors.green,style: ListTileStyle.drawer),
    textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontFamily: 'Roboto')),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF00e0ff)));



ThemeData darkTheme = ThemeData(
  floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.black),
    cardTheme: CardTheme(surfaceTintColor: Colors.purple, elevation: 10),
    
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    primaryColor: Color.fromARGB(255, 13, 13, 14),
    listTileTheme: ListTileThemeData(
      
       tileColor: Colors.black,
        textColor: Colors.white,iconColor: Colors.white,
        style: ListTileStyle.drawer),
    textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontFamily: 'Roboto')),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF00e0ff)));
