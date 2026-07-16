import 'package:flutter/material.dart';
import 'package:pharmacy_app/models/pharmacy_model.dart';
import 'package:pharmacy_app/services/pharmacy_service.dart';

class ResultViewModel {
  final PharmacyService _pharmacyService = PharmacyService();

  final ValueNotifier<List<Pharmacy>> pharmacies =
      ValueNotifier<List<Pharmacy>>([]);
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<bool> hasError = ValueNotifier<bool>(false);

  Future<void> fetchPharmacies({
    required String city,
    required String district,
  }) async {
    isLoading.value = true;

    try {
      final result = await _pharmacyService.fetchPharmacies(city, district);
      pharmacies.value = result ?? [];
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void dispose() {
    pharmacies.dispose();
    isLoading.dispose();
  }
}
