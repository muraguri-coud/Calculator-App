// ignore_for_file: prefer_const_constructors, prefer_conditional_assignment, unnecessary_this

import 'dart:math';

import 'package:calculator/tools/constants.dart';
import 'package:calculator/widgets/Screen.dart';
import 'package:calculator/widgets/answer.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
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
  SharedPreferences? prefs;
  List expressionHistory = List.empty(growable: true);

  elementPassed(value) {
    // print("Am called");
    try {
      this.expression = '${this.expression}${value}';
    } catch (e) {
      expression = "Too long expression";
    }

    setState(() {});
  }

  @override
  initState() {
    super.initState();

    loadStorage();
  }

  loadStorage() async {
    prefs = await SharedPreferences.getInstance();
    expressionHistory.clear();
    for (var element in (prefs?.getKeys().toList() ?? [])) {
      var theli = [
        element ?? "",
        prefs?.getString(element) ?? "",
      ];

      expressionHistory.add(theli);
    }
    setState(() {});
    print(prefs);
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
    try {
      Expression exp = Expression(expression ?? "0");
      //print(exp.eval().toString());
      result = exp.eval().toString();
      prefs?.setString(
          Random.secure().nextDouble().toString(), expression ?? "");

      setState(() {});
    } catch (e) {
      expression = "Syntax Error";
      print("this is the error: $e");
    }

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

  getFromSharedPreference(express) {
    expression = express;
    setState(() {});
  }

  removeFromSharedPreference(value) {
    if (value != null) {
      prefs?.remove(value).then((value) {
        expressionHistory.remove(value);
        loadStorage();
      });
    }
    setState(() {});
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
                  Flexible(
                    child: Container(
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
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
              flex: 3,
              child: Container(
                width: double.maxFinite,
                //image: AssetImage(AssetImageHelper.backgroud_image))),
                color: Color(0xFF8dd8f7),
                child: Column(children: [
                  Flexible(child: _buildMathematicalOperation()),
                  Flexible(child: buildSecondRow()),
                  Flexible(child: buildThirdRow()),
                  //  Flexible(child: lastTwoRows()),

                  Container(
                    //color: Colors.amber,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(

                             //   color: Color.fromARGB(255, 119, 42, 112),
                                width: double.maxFinite,
                                height: 60,

                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        numberPressed(7);
                                        elementPassed(7);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 50,
                                        height: 50,
                                        child: Text("7",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Roboto')),
                                        decoration: BoxDecoration(
                                            // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                                            color: Color(0xFFd8f0fa),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        numberPressed(8);
                                        elementPassed(8);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 50,
                                        height: 50,
                                        child: Text("8",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Roboto')),
                                        decoration: BoxDecoration(
                                            // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                                            color: Color(0xFFd8f0fa),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        numberPressed(8);
                                        elementPassed(8);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 50,
                                        height: 50,
                                        child: Text("8",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Roboto')),
                                        decoration: BoxDecoration(
                                            // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                                            color: Color(0xFFd8f0fa),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        numberPressed(9);
                                        elementPassed(9);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 50,
                                        height: 50,
                                        child: Text("9",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Roboto')),
                                        decoration: BoxDecoration(
                                            // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                                            color: Color(0xFFd8f0fa),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // color: Color.fromARGB(255, 42, 119, 65),
                                width: double.maxFinite,
                                height: 60,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        numberPressed(0);
                                        elementPassed(0);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 120,
                                        height: 50,
                                        child: Text("0",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Roboto')),
                                        decoration: BoxDecoration(
                                            // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                                            color: Color(0xFFd8f0fa),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        elementPassed("%");
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 50,
                                        height: 50,
                                        child: Text("%",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Roboto')),
                                        decoration: BoxDecoration(
                                            // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                                            color: Color(0xFFd8f0fa),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        calculateResult();
                                        loadStorage();
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 50,
                                        height: 50,
                                        child: Text("=",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Roboto')),
                                        decoration: BoxDecoration(
                                            // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                                            color: Color(0xFFd8f0fa),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              elementPassed("+");
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 50,
                              height: 110,
                              child: Text("+",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto')),
                              decoration: BoxDecoration(
                                  // border: Border(top:BorderSide(color: Colors.black ,width: 3)),
                                  color: Color(0xFFd8f0fa),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              )),
          Expanded(
            flex: 2,
            child: Container(
              height: 200,
              child: ListView.builder(
                  itemCount: expressionHistory.length,
                  itemBuilder: ((context, index) {
                    var expre = expressionHistory.reversed.toList()[index][1];
                    var coun = expressionHistory.reversed.toList()[index][0];

                    return InkWell(
                      child: Card(
                        color: Colors.white,
                        elevation: 2.0,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Icon(Icons.assessment),
                          ),
                          title: Text(expre),
                          onTap: () {
                            getFromSharedPreference(expre);
                            calculateResult();
                          },
                          trailing: GestureDetector(
                            child: Icon(
                              Icons.delete,
                              color: Colors.grey,
                            ),
                            onTap: () {
                              removeFromSharedPreference(coun);
                            },
                          ),
                        ),
                      ),
                    );
                  })),
            ),
          )
        ],
      ),
    );
  }

  Widget buildThirdRow() {
    return Padding(
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
    );
  }

  Widget buildSecondRow() {
    return Padding(
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
    );
  }

  Widget _buildMathematicalOperation() {
    return Padding(
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
    );
  }
}
