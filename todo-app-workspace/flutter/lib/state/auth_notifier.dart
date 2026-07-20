import 'package:flutter/material.dart';
import 'package:flutterproject/data/models/user_model.dart';
import 'package:flutterproject/data/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterproject/core/network/dio_client.dart';

class AuthNotifier {
  final AuthService _authService = AuthService(DioClient());

  final ValueNotifier<UserModel?> user = ValueNotifier<UserModel?>(null);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  

  Future<bool> checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    
    return prefs.getString('auth_token') != null ? true : false;
  }

  Future<void> login(String email, String password) async{
    isLoading.value = true;

    try{
      final result = await _authService.login(email: email, password: password);
      user.value = result;
    }catch (e){
      rethrow;
    }finally{
      isLoading.value = false;
    }
  }

  Future<void> register(String name, String email, String password) async{
    isLoading.value = true;

    try{
      final result = await _authService.register(name: name, email: email, password: password);
      user.value=result;
    }catch (e){
      rethrow;
    }finally{
      isLoading.value = false;
    }
  }

  Future<void> logout() async{
    await _authService.logout();
    user.value = null;
  }
}