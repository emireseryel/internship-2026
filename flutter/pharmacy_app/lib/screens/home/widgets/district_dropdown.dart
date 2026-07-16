import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pharmacy_app/screens/home/viewmodels/home_viewmodel.dart';
import 'package:pharmacy_app/localization/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class DistrictDropdown extends StatelessWidget {
  const DistrictDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDistrict = context.select<HomeViewModel, String?>((vm) => vm.selectedDistrict);
    final districts = context.select<HomeViewModel, List<dynamic>>((vm) => vm.districts);

    return DropdownButtonFormField<String>(
      hint: Text(LocaleKeys.select_district.tr()),
      value: (selectedDistrict != null && districts.any((e) => e['text'] == selectedDistrict))
          ? selectedDistrict
          : null,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      items: districts.map((district) {
        return DropdownMenuItem<String>(
          value: district['text'],
          child: Text(district['text']),
        );
      }).toList(),
      onChanged: (newValue) {
        if (newValue != null) {
          context.read<HomeViewModel>().selectDistrict(district: newValue);
        }
      },
    );
  }
}