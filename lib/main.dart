// ignore_for_file: prefer_const_constructors, prefer_conditional_assignment, unnecessary_this, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:calculator/utils/constants.dart';
import 'package:calculator/widgets/Screen.dart';
import 'package:calculator/widgets/answer.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/controller.theme.dart';
import 'utils/themes.dart';
import 'widgets/bmi.dart';
import 'widgets/calculator.dart';

void main() async {
  runApp(MyCalculatorApp());
}

class MyCalculatorApp extends StatefulWidget {
  const MyCalculatorApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyCalculatorApp> createState() => _MyCalculatorAppState();
}

class _MyCalculatorAppState extends State<MyCalculatorApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeController>(
      create: (context) => ThemeController(),
      builder: (context, child) {
        ThemeController themeController = context.watch<ThemeController>();
        return MaterialApp(
            title: 'Advanced Calculator',
            showSemanticsDebugger: false,
            theme: themeController.themeData,
            home: Scaffold(
              backgroundColor:  Color(0xffdddddd),
              

                // drawer: Container(width: 100,color: Colors.white,),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    themeController.toogle();
                  },
                  child: Icon(themeController.islighttheme
                      ? Icons.light_mode
                      : Icons.dark_mode),
                ),
                body: SafeArea(
                  
                    child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            Container(
                            
                              height: 40,
                              child: AppBar(
                                bottom: TabBar(tabs: [
                                  Container(
                                    //color: Colors.white,
                                    child: Text(
                                      "Calculations",
                                      style: TextStyle(
                                         ),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                  Container(
                                   // color: Colors.white,
                                    child: Text(
                                      "BMI",
                                      style: TextStyle(
                                        ),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                ]),
                                backgroundColor: Color(0xff500cd0),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(300)))
                                ,
                                
                                elevation: 0,
                                centerTitle: true,
                                title: Text(
                                  'Advanced Calculator',
                                  style: TextStyle(),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [ const Calculator(),
                                   Bmi(),
                                ],
                              ),
                            ),
                          ],
                        )))));
      },
      child: MaterialApp(
          title: 'My Calculator',
          showSemanticsDebugger: false,
          theme: darkTheme,
          home: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.light_mode),
              ),
              body: SafeArea(child:  Bmi()))),
    );
  }
}
