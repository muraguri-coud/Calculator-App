// ignore_for_file: prefer_const_constructors, prefer_conditional_assignment

import 'package:calculator/widgets/Screen.dart';
import 'package:calculator/widgets/answer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: 'My Calculator',
      showSemanticsDebugger: false,
      home: Scaffold(body: const MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var expression = '';
  int? firstOperand;
  String? operator;
  int? secondOperand;
  int? result;

  // numberPassed(int value) {
  //   this.expression = '${this.expression}${value}';
  //   setState(() {

  //   });
  // }

  numberPressed(int number) {
    setState(() {
      // if (result != null) {
      //   //result = null;
      //   firstOperand = number;
      //   return;
      // }
      if (firstOperand == null) {
        firstOperand = number;
        return;
      }
      if (operator == null) {
        firstOperand = int.parse('$firstOperand$number');
        return;
      }
      if (secondOperand == null) {
        secondOperand = number;
        return;
      }

      secondOperand = int.parse('$secondOperand$number');
    });
  }

  operatorPressed(String operator) {
    setState(() {
      if (firstOperand == null) {
        firstOperand = 0;
      }
      this.operator = operator;
    });
  }

  calculateResult() {
    if (operator == null || secondOperand == null) {
      return;
    }
    setState(() {
      switch (operator) {
        case '+':
          result = (firstOperand! + secondOperand!);
          break;
        case '-':
          result = firstOperand! - secondOperand!;
          break;
        case '*':
          result = firstOperand! * secondOperand!;
          break;
        case '/':
          if (secondOperand == 0) {
            return;
          }
          result = firstOperand! ~/ secondOperand!;
          break;
      }
     

      firstOperand = result;
      operator = null;
      secondOperand = null;
     // result = null;
    });
  }

  clear() {
    setState(() {
      result = null;
      operator = null;
      secondOperand = null;
      firstOperand = null;
    });
  }

  displayResults() {
    if (result != null) {
      print(result);
      return '$result';
    }
    return '0';
  }

  _getDisplayText() {
    print(result);
    if (secondOperand != null) {
      return '$firstOperand$operator$secondOperand';
    }

    if (operator != null) {
      return '$firstOperand$operator';
    }

    if (firstOperand != null) {
      return '$firstOperand';
    }

    return '0';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(maxWidth: 350),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Container(
              width: double.maxFinite,
              color: Colors.blue,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Screenview(
                      result: displayResults(),
                      expression: _getDisplayText(),
                    ),
                    margin: EdgeInsets.all(20),
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          // begin: Alignment.topLeft,
                          tileMode: TileMode.decal,
                          transform: GradientRotation(100),
                          stops: [
                            0,
                            0.1,
                            0.2,
                            0.3,
                            0.4,
                            0.5,
                            0.6,
                            0.7,
                            0.8,
                            0.9,
                            1
                          ],
                          colors: [
                            Color.fromARGB(209, 221, 207, 255),
                            Color.fromARGB(193, 213, 201, 255),
                            Color.fromARGB(209, 221, 207, 255),
                            Color.fromARGB(193, 213, 201, 255),
                            Color.fromARGB(209, 221, 207, 255),
                            Color.fromARGB(193, 213, 201, 255),
                            Color.fromARGB(209, 221, 207, 255),
                            Color.fromARGB(193, 213, 201, 255),
                            Color.fromARGB(209, 221, 207, 255),
                            Color.fromARGB(193, 213, 201, 255),
                            Color.fromARGB(209, 221, 207, 255),
                          ]),
                      // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, spreadRadius: 3)
                      ],
                      color: Color(0xFFd8f0fa),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    width: double.maxFinite,
                  )
                ],
              ),
            ),
          ),
          Expanded(
              flex: 4,
              child: Container(
                width: double.maxFinite,
                color: Color(0xFF8dd8f7),
                child: Column(children: [
                  _buildMathematicalOperation(),
                  buildSecondRow(),
                  buildThirdRow(),
                  lastTwoRows(),
                ]),
              ))
        ],
      ),
    );
  }

  Flexible lastTwoRows() {
    return Flexible(
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                        child: Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () => numberPressed(7),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text("7",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto')),
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                                    color: Color(0xFFd8f0fa),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => numberPressed(8),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text("8",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto')),
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                                    color: Color(0xFFd8f0fa),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => numberPressed(9),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text("9",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto')),
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                                    color: Color(0xFFd8f0fa),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => operatorPressed("/"),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text("/",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto')),
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                                    color: Color(0xFFd8f0fa),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => numberPressed(0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text("0",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto')),
                                width: 120,
                                height: 50,
                                decoration: BoxDecoration(
                                  // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                                  color: Color(0xFFd8f0fa),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              // Container(
                              //     width: 50,
                              //     height: 50,
                              //     color: Color.fromARGB(
                              //         255, 92, 31, 52)),
                              InkWell(
                                onTap: () => operatorPressed(","),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(",",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto')),
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                                    color: Color(0xFFd8f0fa),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => calculateResult(),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text("=",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto')),
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                                    color: Color(0xFFd8f0fa),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    child: InkWell(
                      onTap: () => operatorPressed("+"),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text("+",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto')),
                        width: 50,
                        height: 110,
                        constraints: BoxConstraints(
                          maxHeight: 150,
                          maxWidth: 50,
                        ),
                        decoration: BoxDecoration(
                          // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                          color: Color(0xFFd8f0fa),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Flexible buildThirdRow() {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () => numberPressed(4),
              child: Container(
                alignment: Alignment.center,
                child: Text("4",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto')),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                    color: Color(0xFFd8f0fa),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            InkWell(
              onTap: () => numberPressed(5),
              child: Container(
                alignment: Alignment.center,
                child: Text("5",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto')),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                    color: Color(0xFFd8f0fa),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            InkWell(
              onTap: () => numberPressed(6),
              child: Container(
                alignment: Alignment.center,
                child: Text("6",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto')),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                    color: Color(0xFFd8f0fa),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            InkWell(
              onTap: () => operatorPressed("*"),
              child: Container(
                alignment: Alignment.center,
                child: Text("*",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto')),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                    color: Color(0xFFd8f0fa),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            InkWell(
              onTap: () => operatorPressed("-"),
              child: Container(
                alignment: Alignment.center,
                child: Text("−",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto')),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                    color: Color(0xFFd8f0fa),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Flexible buildSecondRow() {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () => numberPressed(1),
              child: Container(
                alignment: Alignment.center,
                child: Text("1",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto')),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                    color: Color(0xFFd8f0fa),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            InkWell(
              onTap: () => numberPressed(2),
              child: Container(
                alignment: Alignment.center,
                child: Text("2",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto')),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                    color: Color(0xFFd8f0fa),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            InkWell(
              onTap: () => numberPressed(3),
              child: Container(
                alignment: Alignment.center,
                child: Text("3",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto')),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                    color: Color(0xFFd8f0fa),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            InkWell(
              onTap: () => operatorPressed("="),
              child: Container(
                alignment: Alignment.center,
                child: Text("±",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto')),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                    color: Color(0xFFd8f0fa),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            InkWell(
              onTap: () => operatorPressed("%"),
              child: Container(
                alignment: Alignment.center,
                child: Text("%",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto')),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                    color: Color(0xFFd8f0fa),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Flexible _buildMathematicalOperation() {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () => operatorPressed("CE"),
              child: Container(
                alignment: Alignment.center,
                child: Text("CE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto')),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                    color: Color(0xFFd8f0fa),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            InkWell(
              onTap: () => clear(),
              child: Container(
                alignment: Alignment.center,
                child: Text("C",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto')),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                    color: Color(0xFFd8f0fa),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            InkWell(
              onTap: () => operatorPressed("M+"),
              child: Container(
                alignment: Alignment.center,
                child: Text("M+",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto')),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                    color: Color(0xFFd8f0fa),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            InkWell(
              onTap: () => operatorPressed("M-"),
              child: Container(
                alignment: Alignment.center,
                child: Text("M-",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto')),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                    color: Color(0xFFd8f0fa),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            InkWell(
              onTap: () => operatorPressed("MR"),
              child: Container(
                alignment: Alignment.center,
                child: Text("MR",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto')),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                    color: Color(0xFFd8f0fa),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
