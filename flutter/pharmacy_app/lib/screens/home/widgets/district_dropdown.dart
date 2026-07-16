import 'package:flutter/material.dart';
import 'package:pharmacy_app/screens/home/viewmodels/home_viewmodel.dart';
import 'package:pharmacy_app/localization/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class DistrictDropdown extends StatelessWidget {
  final HomeViewModel viewModel;
  const DistrictDropdown({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<dynamic>>(
      valueListenable: viewModel.districts,
      builder: (context, districts, child) {
        return ValueListenableBuilder<String?>(
          valueListenable: viewModel.selectedDistrict,
          builder: (context, selectedDistrict, child) {
            
            // Eğer gelen liste boşsa dropdown'ı disable etmek en temiz kullanıcı deneyimidir kanka
            final bool isEnabled = districts.isNotEmpty;

            // Seçilen değer listede var mı kontrolü
            final String? currentValue = (selectedDistrict != null && 
                    districts.any((e) => e['text'] == selectedDistrict))
                ? selectedDistrict
                : null;

            return DropdownButtonFormField<String>(
              key: ValueKey('${viewModel.selectedCity.value}_${districts.length}'),
              hint: Text(LocaleKeys.select_district.tr()),
              value: currentValue,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              // districts boşsa null veriyoruz, böylece dropdown tıklanamaz (disabled) oluyor
              items: isEnabled 
                  ? districts.map((district) {
                      return DropdownMenuItem<String>(
                        value: district['text'].toString(),
                        child: Text(district['text'].toString()),
                      );
                    }).toList()
                  : null,
              onChanged: isEnabled 
                  ? (newValue) {
                      if (newValue != null) {
                        viewModel.selectDistrict(district: newValue);
                      }
                    }
                  : null,
            );
          }
        );
      }
    );
  }
}