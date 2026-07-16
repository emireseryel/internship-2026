import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailViewModel {
  final ValueNotifier<bool> isFavorite = ValueNotifier<bool>(false);



  Future<void> loadFavoriteStatus(String pharmacyName) async {
    final prefs = await SharedPreferences.getInstance();
    isFavorite.value = prefs.getBool(pharmacyName) ?? false;
  }


  Future<void> toggleFavorite(String pharmacyName) async {
    final prefs = await SharedPreferences.getInstance();
    
    isFavorite.value = !isFavorite.value;
    await prefs.setBool(pharmacyName, isFavorite.value);
  }

  void dispose() {
  isFavorite.dispose();
}

}