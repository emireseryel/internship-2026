import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailViewModel extends ChangeNotifier {
  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;


  Future<void> loadFavoriteStatus(String pharmacyName) async {
    final prefs = await SharedPreferences.getInstance();
    _isFavorite = prefs.getBool(pharmacyName) ?? false;
    notifyListeners();
  }


  Future<void> toggleFavorite(String pharmacyName) async {
    final prefs = await SharedPreferences.getInstance();
    
    _isFavorite = !_isFavorite;
    await prefs.setBool(pharmacyName, _isFavorite);

    notifyListeners();
  }


}