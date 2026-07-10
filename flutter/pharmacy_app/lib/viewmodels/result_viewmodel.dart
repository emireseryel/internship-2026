import 'package:flutter/material.dart';
import 'package:pharmacy_app/models/pharmacy_model.dart';
import 'package:pharmacy_app/services/pharmacy_service.dart';
import 'package:easy_localization/easy_localization.dart';

class ResultViewModel extends ChangeNotifier{
  final PharmacyService _pharmacyService = PharmacyService();

  List<Pharmacy> _pharmacies = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Pharmacy> get pharmacies => _pharmacies;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPharmacies({required String city, required String district}) async{
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try{
      final result = await _pharmacyService.fetchPharmacies(city, district);
      _pharmacies = result ?? [];
    }catch (e){
      _errorMessage = 'network_api_error'.tr();
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }
}