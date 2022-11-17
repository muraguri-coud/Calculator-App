// ignore_for_file: prefer_const_constructors

import 'package:calculator/controllers/bmi.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class Bmi extends StatelessWidget {
    TextEditingController weightController = TextEditingController(text: "0");
  TextEditingController heightController = TextEditingController(text: "0");
   Bmi({super.key});

  @override
  Widget build(BuildContext context) {
  
    return Container(
      //margin: EdgeInsets.all(10.0),
      alignment: Alignment.center,
      color: Color(0xFFe4e4e4),
      child: ChangeNotifierProvider(
        create: (context) => BmiController(),
        builder: (context, child) {
          BmiController bmiController = context.watch<BmiController>();
          return Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            // color: Colors.white,
            child: Column(children: [
              // Container(
              //   padding: EdgeInsets.fromLTRB(0, 0, 0, 20),

              //   width: 400,
              //   // ignore: sort_child_properties_last
              //   child: Text(
              //     "Advaced Calculator",
              //     style: TextStyle(
              //         fontSize: 25, color: Colors.red, fontStyle: FontStyle.italic),
              //   ),
              //   alignment: Alignment.center,
              // ),

              Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      "Enter your height and weight below and tap \'Calculate BMI\'",
                      style: TextStyle(fontSize: 20),
                    ),
                  ))
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      // color: Colors.red,
                      margin: const EdgeInsets.only(top: 25),

                      child: Text(
                        "Height(cm)",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                      //alignment: Alignment.bottomLeft,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 25),
                      padding: EdgeInsets.only(left: 10),

                      // color: Colors.red,
                      // margin: const EdgeInsets.all(10.0),

                      child: Text(
                        "Weight(kg)",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                      //  alignment: Alignment.bottomLeft,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: TextFormField(
                        controller: weightController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: Color(0xFFbababa), width: 2)),
                          fillColor: Color(0xFFf0f0f0),
                          filled: true,
                          contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 0),

                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.all(Radius.circular(10)),
                          //     ),
                          hintText: '160',

                          // labelText: 'Height *',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: TextFormField(
                        controller: heightController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: Color(0xFFbababa), width: 2)),
                          fillColor: Color(0xFFf0f0f0),
                          filled: true,
                          contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 0),

                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.all(Radius.circular(10)),
                          //     ),
                          hintText: '101.2',

                          // labelText: 'Height *',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  margin: new EdgeInsets.only(top: 25),
                  width: 400,
                  height: 50.0,
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        surfaceIntensity: 5,
                        intensity: 5,
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12)),
                        depth: -10,
                        lightSource: LightSource.topLeft,
                        color: Color(0xfff2f2f2)),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(
                            width: 2.0,
                            color: Color(0xFFbababa),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          elevation: 10,
                          shadowColor: Color(0xFFbfbfbf),
                          backgroundColor: Color(0xFFd6d6d6),
                        ),
                        onPressed: () {
                                    bmiController.calculateBmi(heightController.text, weightController.text);

                        },
                        child: Text(
                          'Calculate MY BMI',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        )),
                  )),
              Container(
                  margin: new EdgeInsets.only(top: 20),
                  width: 400,
                  height: 50.0,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          width: 2.0,
                          color: Color(0xFFbababa),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        elevation: 10,
                        backgroundColor: Color(0xFFf4f4f4),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Reset',
                        style:
                            TextStyle(color: Color(0xFF363636), fontSize: 20),
                      ))),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    child: Text("Body Mass Index ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  ))
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Neumorphic(
                      style: NeumorphicStyle(
                          surfaceIntensity: 5,
                          intensity: 5,
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12)),
                          depth: -10,
                          lightSource: LightSource.topLeft,
                          color: Color(0xfff2f2f2)),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFf3f3f3),
                                width: 2.0,
                              ),
                              color: Color(0xFFf0f0f0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          height: 45.0,
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: Text(
                            '${bmiController.bmi}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF363636),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
              Row(children: [
                Expanded(
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        surfaceIntensity: 5,
                        intensity: 5,
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12)),
                        depth: -10,
                        lightSource: LightSource.topLeft,
                        color: Color(0xfff2f2f2)),
                    child: Container(
                        margin: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFFf3f3f3),
                              width: 2.0,
                            ),
                            color: Color(0xFFf0f0f0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        height: 45.0,
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Text(
                         '${bmiController.category}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF363636),
                          ),
                        )),
                  ),
                ),
              ]),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(top: 25),
                    child: Text(
                      "This calculator displays a scientifically accurate BMI result without rounding up the values.",
                      style: TextStyle(fontSize: 20),
                    ),
                  ))
                ],
              ),
            ]),
          );
        },
      ),

      //  children: [Text("BMI"), Text("Calculator")],
    );
  }
}
