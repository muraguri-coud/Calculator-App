import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class BmiController extends ChangeNotifier {
  //https://bmi-express-app.herokuapp.com/api/0/0/34/343
  var bmi='';
  var category='';
  clear() {
    bmi = 
    '';
    category = '';
    notifyListeners();
  }

  calculateBmi(var height, var weight) async {
    var url = new Uri.https(
        "bmi-express-app.herokuapp.com", "/api/0/0/${weight}/${height}");
    var response = await http.get(url);
    print(response.statusCode);
    var body = jsonDecode(response.body);
    bmi = body["bmi"];
    category = body["category"];
    notifyListeners();

    print(response.body);
  }
}
