import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/themes.dart';

class ThemeController extends ChangeNotifier {
  ThemeData themeData = appTheme;
  bool islighttheme = true;
  toogle() {
    themeData  = islighttheme ? darkTheme : appTheme;
    this.islighttheme = !islighttheme;
    notifyListeners();
  }
}
