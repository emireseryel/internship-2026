import 'package:flutter/material.dart';
import 'package:pharmacy_app/screens/home/viewmodels/home_viewmodel.dart';
import 'package:pharmacy_app/screens/result/views/result_page.dart';
import 'package:pharmacy_app/localization/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchButton extends StatelessWidget {
  final HomeViewModel viewModel;
  const SearchButton({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        final city = viewModel.selectedCity.value;
        final district = viewModel.selectedDistrict.value;

        if (district != null && district.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(
                city: city,
                dist: district,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(LocaleKeys.warning_select_district.tr()),
            ),
          );
        }
      },
      icon: const Icon(Icons.search),
      label: const Text(''),
    );
  }
}