import 'package:flutter/material.dart';


class ThemeViewModel extends ChangeNotifier{
  var themeMode = ThemeMode.system;
 

  void toggleTheme(BuildContext context){
    if (Theme.of(context).brightness == Brightness.dark){
      themeMode = ThemeMode.light;
    }else{
      themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }

}