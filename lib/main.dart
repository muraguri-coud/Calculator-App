// ignore_for_file: prefer_const_constructors, prefer_conditional_assignment, unnecessary_this

import 'package:calculator/widgets/Screen.dart';
import 'package:calculator/widgets/answer.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // Size size = await DesktopWindow.getWindowSize();
  // print(size);
  // await DesktopWindow.setWindowSize(Size(500, 500));

  // await DesktopWindow.setMinWindowSize(Size(400, 400));
  // await DesktopWindow.setMaxWindowSize(Size(800, 800));

  // await DesktopWindow.resetMaxWindowSize();
  // await DesktopWindow.toggleFullScreen();
  // bool isFullScreen = await DesktopWindow.getFullScreen();
  // await DesktopWindow.setFullScreen(true);
  // await DesktopWindow.setFullScreen(false);

  runApp(MaterialApp(
      title: 'My Calculator',
      showSemanticsDebugger: false,
      home: Scaffold(body: SafeArea(child: const MyApp()))));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? expression = '';
  int? firstOperand;
  String? operator;
  // String? operator2;
  int? secondOperand;
  String? result;
  double memory = 0;

  elementPassed(value) {
    this.expression = '${this.expression}${value}';
    setState(() {});
  }

  addInMemory() {
    if (result != null) {
      memory = memory + (double.parse((result ?? "0.")));
      print(memory);
      setState(() {});
    }
  }

  removeInMemory() {
    memory = memory - (double.parse((result ?? "0.")));
    setState(() {});
  }

  getInMemory() {
    expression = memory.toString();
    setState(() {});
  }

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
    Expression exp = Expression(expression ?? "0");
    //print(exp.eval().toString());
    result = exp.eval().toString();
    setState(() {});
  }

  clear() {
    setState(() {
      result = null;
      operator = null;

      secondOperand = null;
      firstOperand = null;
      expression = "";
      memory = 0;
    });
  }

  del() {
    setState(() {
      if (expression != null) {
        // expression = expression?.substring(0, expression?.length ?? 1 - 1);
        print(expression?.length);
        if ((expression?.length ?? 0) >= 1) {
          expression =
              expression?.replaceRange((expression?.length ?? 1) - 1, null, '');
          print(expression);
          //  secondOperand?.remove();
        }
      }
    });
  }

  displayResults() {
    if (result != null) {
      return '$result';
    }
    return '0';
  }

  _getDisplayText() {
    // if (operator2 != null && secondOperand != null) {
    //   return '$firstOperand$operator$secondOperand$operator2';
    // }
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
      //constraints: BoxConstraints(maxWidth: 350),
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
                      expression: expression,
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
                                onTap: () {
                                  numberPressed(7);
                                  elementPassed(7);
                                },
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
                                onTap: () {
                                  numberPressed(8);
                                  elementPassed(8);
                                },
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
                                onTap: () {
                                  numberPressed(9);
                                  elementPassed(9);
                                },
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
                                onTap: () {
                                  operatorPressed("/");
                                  elementPassed("/");
                                },
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
                        onTap: () {
                          numberPressed(0);
                          elementPassed(0);
                        },
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
                                onTap: () {
                                  operatorPressed("%");
                                  elementPassed("%");
                                },
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
                      onTap: () {
                        operatorPressed("+");
                        elementPassed("+");
                      },
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
              onTap: () {
                numberPressed(4);
                elementPassed(4);
              },
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
              onTap: () {
                numberPressed(5);
                elementPassed(5);
              },
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
              onTap: () {
                numberPressed(6);
                elementPassed(6);
              },
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
              onTap: () {
                operatorPressed("*");
                elementPassed("*");
              },
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
              onTap: () {
                operatorPressed("-");
                elementPassed("-");
              },
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
              onTap: () {
                numberPressed(1);
                elementPassed(1);
              },
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
              onTap: () {
                numberPressed(2);
                elementPassed(2);
              },
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
              onTap: () {
                numberPressed(3);
                elementPassed(3);
              },
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
              onTap: () {
                operatorPressed("(");
                elementPassed("(");
              },
              child: Container(
                alignment: Alignment.center,
                child: Text("(",
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
              onTap: () {
                operatorPressed(")");
                elementPassed(")");
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(")",
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
              //onTap: () => clear(),
              child: Container(
                alignment: Alignment.center,
                child: IconButton(
                    onPressed: () {
                      del();
                    },
                    icon: Icon(Icons.backspace)),
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
              onTap: () => addInMemory(),
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
              onTap: () => removeInMemory(),
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
              onTap: () => getInMemory(),
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
