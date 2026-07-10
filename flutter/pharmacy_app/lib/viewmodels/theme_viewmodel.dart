import 'package:flutter/material.dart';


class ThemeViewModel extends ChangeNotifier{
  var themeMode = ThemeMode.system;


  void toggleTheme(){
    (themeMode.isLight) ? themeMode=ThemeMode.dark : themeMode=ThemeMode.light;
    notifyListeners();
  }

}