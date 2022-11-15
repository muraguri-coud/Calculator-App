// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Screenview extends StatelessWidget {
  var expression;
  var result;

  Screenview({this.expression, this.result, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blue,
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Text("${expression}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'DS-DIGIT'))),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("${result}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'DS-DIGIT')),
            ],
          ),
        ],
      ),
    );
  }
}
