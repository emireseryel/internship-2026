import 'package:flutterproject/core/constants/api_constants.dart';
import 'package:flutterproject/core/network/dio_client.dart';
import 'package:flutterproject/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final DioClient _dioClient;
  
  AuthService(this._dioClient);

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await _dioClient.dio.post(
      ApiConstants.register,
      data: {'name': name, 'email': email, 'password': password, 'passwordConfirmation': passwordConfirmation,},
    );

    final token = response.data['access_token'];
    final userData = response.data['user'];

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);

    return UserModel.fromJson(userData);
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _dioClient.dio.post(
      ApiConstants.login,
      data: {'email': email, 'password': password, 'device_name': 'flutter_app',},
    );

    final token = response.data['access_token'];
    final userData = response.data['user'];

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);

    return UserModel.fromJson(userData);
  }

  Future<void> logout() async {
    await _dioClient.dio.post(ApiConstants.logout);

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}
