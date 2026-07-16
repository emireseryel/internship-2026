import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pharmacy_app/screens/home/viewmodels/home_viewmodel.dart';
import 'package:pharmacy_app/localization/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class CityDropdown extends StatelessWidget {
  const CityDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final cities = context.select<HomeViewModel, List<String>>((vm) => vm.cities);
    final selectedCity = context.select<HomeViewModel, String>((vm) => vm.selectedCity);

    return DropdownButtonFormField<String>(
      hint: Text(LocaleKeys.select_city.tr()),
      value: selectedCity.isEmpty ? null : selectedCity,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      items: cities
          .map((city) => DropdownMenuItem(value: city, child: Text(city)))
          .toList(),
      onChanged: (newValue) {
        if (newValue != null) {
          context.read<HomeViewModel>().selectCity(city: newValue);
        }
      },
    );
  }
}