import 'package:flutter/material.dart';
import 'package:pharmacy_app/screens/home/viewmodels/home_viewmodel.dart';
import 'package:pharmacy_app/localization/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class CityDropdown extends StatelessWidget {
  final HomeViewModel viewModel;
  const CityDropdown({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: viewModel.selectedCity,
      builder: (context, selectedCity, child) {
        return DropdownButtonFormField<String>(
          hint: Text(LocaleKeys.select_city.tr()),
          value: selectedCity.isEmpty ? null : selectedCity,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
          
          items: viewModel.cities
              .map((city) => DropdownMenuItem(value: city, child: Text(city)))
              .toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              viewModel.selectCity(city: newValue);
            }
          },
        );
      },
    );
  }
}